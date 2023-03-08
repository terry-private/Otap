//
//  ViewModelTests.swift
//  
//
//  Created by 若江照仁 on 2023/03/07.
//

import XCTest
@testable import Core
@testable import FeatureVoiceQuiz
@testable import Utility

final class ViewModelTests: XCTestCase {
    enum SoundEffectStub: SoundEffectUseCase {
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
        static func speak(_ words: String) {
            spokenWords = words
        }
    }
    
    final class VoiceQuizUseCaseStub: VoiceQuizUseCase {
        typealias Quiz = VoiceQuizDummy
        private var quizzes: [Quiz] = [
            .init(options: [.red, .yellow], answer: .red),
            .init(options: [.black, .blue], answer: .blue)
        ]
        private var correctCount: Int = 0
        var lastRecord: Core.GameRecord = .init(id: .colorBasic1)
        var timeLimit: Double
        var verifyDuration: Double = 0.01
        var penalty: Core.PenaltyType
        var quizCount: Int { quizzes.count }
        var wrongCount: Int = 0
        var requirements: String = ""
        var star1Description: String = ""
        var star2Description: String = ""
        var star3Description: String = ""
        func clearTestResult(time: Double) -> GameResult {
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
        func recordQuizResult(isCorrect: Bool) {
            if isCorrect {
                correctCount += 1
            } else {
                wrongCount += 1
            }
        }
        func gameResult(time: Double) -> Core.GameResult {
            if correctCount == quizCount {
                return clearTestResult(time: time)
            } else if time >= timeLimit {
                return .timeOver
            } else {
                return .gameOver
            }
        }
        func refresh() async throws {}
        func nextQuiz() -> Core.VoiceQuizDummy {
            VoiceQuizLevelSelectorDummy.level1.generator.quizzes().first!
        }
        init(timeLimit: Double = 1, penalty: PenaltyType) {
            self.timeLimit = timeLimit
            self.penalty = penalty
        }
    }
    
    @MainActor
    func testクリアまでのシナリオ() async throws {
        let useCase: VoiceQuizUseCaseStub = .init(penalty: .gameOver)
        let viewModel = VoiceQuizViewModelImpl<VoiceQuizDummy, SoundEffectStub, VoiceQuizUseCaseStub>(useCase: useCase, dismiss: {})
        XCTContext.runActivity(named: "ゲーム開始時") {_ in
            XCTAssertEqual(viewModel.gameState, .ready, "GameStateが.ready")
            XCTAssertEqual(viewModel.remainQuizCount, useCase.quizCount, "残りの問題数が総問題数と一致")
            XCTAssertEqual(viewModel.wrongCount, 0, "失敗数が0")
        }
        
        viewModel.start()
        XCTContext.runActivity(named: "第1問 開始時") {_ in
            XCTAssertEqual(viewModel.gameState, .playing, "GameStateが.playing")
            XCTAssertEqual(viewModel.remainQuizCount, useCase.quizCount, "残りの問題数が総問題数と一致")
            XCTAssertEqual(viewModel.wrongCount, 0, "失敗数が0")
            XCTAssertEqual(SoundEffectStub.spokenWords, viewModel.currentQuiz.answer.call, "読み上げと第一問の答えが一致")
        }
                
        let verifyTask1 = viewModel.optionTapped(viewModel.currentQuiz.answer)
        XCTContext.runActivity(named: "第1問 正解解答時") {_ in
            XCTAssertEqual(viewModel.gameState, .verifying(viewModel.currentQuiz.answer), "GameStateが.verifying(解答したOption)")
            XCTAssertTrue(SoundEffectStub.isPlayCorrect, "正解の音声が流れた")
            XCTAssertEqual(viewModel.remainQuizCount, useCase.quizCount-1, "残りの問題数一つ減ってる")
        }
        
        _ = await verifyTask1.result
        
        XCTContext.runActivity(named: "第2問 開始時") {_ in
            XCTAssertEqual(viewModel.gameState, .playing, "GameStateが.playing")
            XCTAssertEqual(viewModel.remainQuizCount, useCase.quizCount-1, "残りの問題数が総問題数-1")
            XCTAssertEqual(viewModel.wrongCount, 0, "失敗数が0")
            XCTAssertEqual(SoundEffectStub.spokenWords, viewModel.currentQuiz.answer.call, "読み上げと第2問の答えが一致")
        }
        let verifyTask2 = viewModel.optionTapped(viewModel.currentQuiz.answer)
        let time = viewModel.time
        XCTContext.runActivity(named: "第2問 正解解答時") {_ in
            XCTAssertEqual(viewModel.gameState, .verifying(viewModel.currentQuiz.answer), "GameStateが.verifying(解答したOption)")
            XCTAssertTrue(SoundEffectStub.isPlayCorrect, "正解の音声が流れた")
            XCTAssertEqual(viewModel.remainQuizCount, useCase.quizCount-2, "残りの問題数2つ減ってる")
        }
        
        _ = await verifyTask2.result
        XCTContext.runActivity(named: "第2問 判定結果") {_ in
            XCTAssertEqual(viewModel.time, time, "ゲーム終了判定の場合、解答時にタイマーがストップするので0.01秒経ってもtimeに変更がない")
            XCTAssertEqual(viewModel.gameState, .gameOver(useCase.clearTestResult(time: time)), "GameStateが.gameOver(.success(.useCase.clearTestResult))")
        }
    }
    
    @MainActor
    func testペナルティによるGameOver() async throws {
        let useCase: VoiceQuizUseCaseStub = .init(penalty: .gameOver)
        let viewModel = VoiceQuizViewModelImpl<VoiceQuizDummy, SoundEffectStub, VoiceQuizUseCaseStub>(useCase: useCase, dismiss: {})
        
        viewModel.start()
        
        let wrongAnswer = viewModel.currentQuiz.options.first! == viewModel.currentQuiz.answer ? viewModel.currentQuiz.options.last! : viewModel.currentQuiz.options.first!
        let verifyTask = viewModel.optionTapped(wrongAnswer)
        let time = viewModel.time
        XCTContext.runActivity(named: "第1問 正解解答時") {_ in
            XCTAssertEqual(viewModel.gameState, .verifying(wrongAnswer), "GameStateが.verifying(解答したOption)")
            XCTAssertTrue(SoundEffectStub.isPlayWrong, "失敗の音声が流れた")
            XCTAssertEqual(viewModel.remainQuizCount, useCase.quizCount, "残りの問題数が減っていない")
        }
        
        _ = await verifyTask.result
        XCTContext.runActivity(named: "第1問 判定結果") {_ in
            XCTAssertEqual(viewModel.time, time, "ゲーム終了判定の場合、解答時にタイマーがストップするので0.01秒経ってもtimeに変更がない")
            XCTAssertEqual(viewModel.gameState, .gameOver(.gameOver), "GameStateが.gameOver(.gameOver)")
        }
    }
    
    @MainActor
    func testタイムオーバーによるGameOver() async throws {
        let useCase: VoiceQuizUseCaseStub = .init(timeLimit: 0.01, penalty: .gameOver)
        let viewModel = VoiceQuizViewModelImpl<VoiceQuizDummy, SoundEffectStub, VoiceQuizUseCaseStub>(useCase: useCase, dismiss: {})
        
        viewModel.start()
        try await Task.sleep(seconds: 0.02)
        XCTContext.runActivity(named: "timelimit後") {_ in
            XCTAssertEqual(viewModel.gameState, .gameOver(.timeOver), "GameStateが.gameOver(.timeOver)")
        }
    }
}
