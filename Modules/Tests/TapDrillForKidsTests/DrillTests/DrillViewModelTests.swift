//
//  DrillViewModelTests.swift
//  
//
//  Created by 若江照仁 on 2023/03/07.
//

import XCTest
@testable import Core
@testable import FeatureDrill
@testable import Utility

final class DrillViewModelTests: XCTestCase {
    enum SoundEffectStub: SoundEffectUseCase {
        static var utteranceLanguage: Core.UtteranceLanguage = .system
        
        static var effectVolume: Float = 0
        
        static var utteranceVolume: Float = 0
        
        static var isPlayCorrect: Bool = false
        static var isPlayWrong: Bool = false
        static var spokenWords: String? = nil
        static func readyAllPlayer() {}
        static func playCorrect() {
            isPlayCorrect = true
        }
        static func playWrong() {
            isPlayWrong = true
        }
        static func speak(_ words: String, _ specificLanguage: String) {
            spokenWords = words
        }
    }
    
    final class DrillUseCaseStub: DrillUseCase {
        var levelTitle: String { Drill.title }
        
        typealias Drill = DrillDummy
        private var drills: [Drill] = [
            .init(options: [.red, .yellow], answer: .red),
            .init(options: [.black, .blue], answer: .blue)
        ]
        private var correctCount: Int = 0
        var lastRecord: Core.DrillRecord = .init(id: .colorBasic1)
        var timeLimit: Double
        var verifyDuration: Double = 0.01
        var penalty: Core.PenaltyType
        var drillCount: Int { drills.count }
        var wrongCount: Int = 0
        var requirements: String = ""
        var star1Description: String = ""
        var star2Description: String = ""
        var star3Description: String = ""
        func clearTestResult(time: Double) -> DrillResult {
            .success(
                .init(
                    star1: .unlocked(isFirst: true),
                    star2: .unlocked(isFirst: true),
                    star3: .locked,
                    time: time,
                    isNewTimeRecord: true
                )
            )
        }
        func recordDrillResult(isCorrect: Bool) {
            if isCorrect {
                correctCount += 1
            } else {
                wrongCount += 1
            }
        }
        func drillResult(time: Double) -> Core.DrillResult {
            if correctCount == drillCount {
                return clearTestResult(time: time)
            } else if time >= timeLimit {
                return .timeOver
            } else {
                return .gameOver
            }
        }
        func refresh() async throws {}
        func nextDrill() -> Core.DrillDummy {
            DrillLevelSelectorDummy.level1.generator.generate().first!
        }
        init(timeLimit: Double = 1, penalty: PenaltyType) {
            self.timeLimit = timeLimit
            self.penalty = penalty
        }
    }
    
    @MainActor
    func testクリア後再開するまでのシナリオ() async throws {
        let useCase: DrillUseCaseStub = .init(penalty: .gameOver)
        let viewModel = DrillViewModelImpl<DrillDummy, SoundEffectStub, DrillUseCaseStub>(useCase: useCase, dismiss: {})
        XCTContext.runActivity(named: "ゲーム開始時") {_ in
            XCTAssertEqual(viewModel.drillState, .ready, "DrillStateが.ready")
            XCTAssertEqual(viewModel.remainDrillCount, useCase.drillCount, "残りの問題数が総問題数と一致")
            XCTAssertEqual(viewModel.wrongCount, 0, "失敗数が0")
        }
        
        viewModel.start()
        XCTContext.runActivity(named: "第1問 開始時") {_ in
            XCTAssertEqual(viewModel.drillState, .playing, "DrillStateが.playing")
            XCTAssertEqual(viewModel.remainDrillCount, useCase.drillCount, "残りの問題数が総問題数と一致")
            XCTAssertEqual(viewModel.wrongCount, 0, "失敗数が0")
            XCTAssertEqual(SoundEffectStub.spokenWords, viewModel.currentDrill.answer.call("ja"), "読み上げと第一問の答えが一致")
        }
                
        let verifyTask1 = viewModel.optionTapped(viewModel.currentDrill.answer)
        XCTContext.runActivity(named: "第1問 正解解答時") {_ in
            XCTAssertEqual(viewModel.drillState, .verifying(viewModel.currentDrill.answer), "DrillStateが.verifying(解答したOption)")
            XCTAssertTrue(SoundEffectStub.isPlayCorrect, "正解の音声が流れた")
            XCTAssertEqual(viewModel.remainDrillCount, useCase.drillCount-1, "残りの問題数一つ減ってる")
        }
        
        _ = await verifyTask1.result
        
        XCTContext.runActivity(named: "第2問 開始時") {_ in
            XCTAssertEqual(viewModel.drillState, .playing, "DrillStateが.playing")
            XCTAssertEqual(viewModel.remainDrillCount, useCase.drillCount-1, "残りの問題数が総問題数-1")
            XCTAssertEqual(viewModel.wrongCount, 0, "失敗数が0")
            XCTAssertEqual(SoundEffectStub.spokenWords, viewModel.currentDrill.answer.call("ja"), "読み上げと第2問の答えが一致")
        }
        let verifyTask2 = viewModel.optionTapped(viewModel.currentDrill.answer)
        let time = viewModel.time
        XCTContext.runActivity(named: "第2問 正解解答時") {_ in
            XCTAssertEqual(viewModel.drillState, .verifying(viewModel.currentDrill.answer), "DrillStateが.verifying(解答したOption)")
            XCTAssertTrue(SoundEffectStub.isPlayCorrect, "正解の音声が流れた")
            XCTAssertEqual(viewModel.remainDrillCount, useCase.drillCount-2, "残りの問題数2つ減ってる")
        }
        
        _ = await verifyTask2.result
        XCTContext.runActivity(named: "第2問 判定結果") {_ in
            XCTAssertTrue(abs(viewModel.time - time) <= 0.01, "ゲーム終了判定の場合、解答時にタイマーがストップするので解答時と判定後のtimeの誤差0.01秒以下")
            XCTAssertEqual(viewModel.drillState, .gameOver(useCase.clearTestResult(time: viewModel.time)), "DrillStateが.gameOver(.success(.useCase.clearTestResult))")
        }
        
        viewModel.optionTapped(viewModel.currentDrill.answer)
        XCTContext.runActivity(named: "ゲームオーバーの状態でタップできた場合") {_ in
            XCTAssertEqual(viewModel.drillState, .gameOver(useCase.clearTestResult(time: viewModel.time)), "verifyにならず.gameOverのまま")
        }
        
        viewModel.restart()
        let duration = Date()
        while viewModel.isLoading { // useCase.refreshが完了するまで待つ
            await Task.yield()
            if duration.timeIntervalSinceNow < -3 { fatalError("cant refresh") }
        }
        XCTContext.runActivity(named: "リスタート時の状態") {_ in
            XCTAssertEqual(viewModel.drillState, .ready, "DrillStateが.ready")
            XCTAssertEqual(viewModel.remainDrillCount, useCase.drillCount, "残りの問題数が総問題数と一致")
            XCTAssertEqual(viewModel.wrongCount, 0, "失敗数が0")
        }
    }
    
    @MainActor
    func testペナルティによるGameOver() async throws {
        let useCase: DrillUseCaseStub = .init(penalty: .gameOver)
        let viewModel = DrillViewModelImpl<DrillDummy, SoundEffectStub, DrillUseCaseStub>(useCase: useCase, dismiss: {})
        
        viewModel.start()
        
        let wrongAnswer = viewModel.currentDrill.options.first! == viewModel.currentDrill.answer ? viewModel.currentDrill.options.last! : viewModel.currentDrill.options.first!
        let verifyTask = viewModel.optionTapped(wrongAnswer)
        let time = viewModel.time
        XCTContext.runActivity(named: "第1問 正解解答時") {_ in
            XCTAssertEqual(viewModel.drillState, .verifying(wrongAnswer), "DrillStateが.verifying(解答したOption)")
            XCTAssertTrue(SoundEffectStub.isPlayWrong, "失敗の音声が流れた")
            XCTAssertEqual(viewModel.remainDrillCount, useCase.drillCount, "残りの問題数が減っていない")
        }
        
        _ = await verifyTask.result
        XCTContext.runActivity(named: "第1問 判定結果") {_ in
            XCTAssertTrue(abs(viewModel.time - time) <= 0.01, "ゲーム終了判定の場合、解答時にタイマーがストップするので解答時と判定後のtimeの誤差0.01秒以下")
            XCTAssertEqual(viewModel.drillState, .gameOver(.gameOver), "DrillStateが.gameOver(.gameOver)")
        }
    }
    
    @MainActor
    func testタイムオーバーによるGameOver() async throws {
        let useCase: DrillUseCaseStub = .init(timeLimit: 0.01, penalty: .gameOver)
        let viewModel = DrillViewModelImpl<DrillDummy, SoundEffectStub, DrillUseCaseStub>(useCase: useCase, dismiss: {})
        
        viewModel.start()
        try await Task.sleep(seconds: 0.02)
        XCTContext.runActivity(named: "timelimit後") {_ in
            XCTAssertEqual(viewModel.drillState, .gameOver(.timeOver), "DrillStateが.gameOver(.timeOver)")
        }
    }
}
