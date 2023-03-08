//
//  ViewModelTests.swift
//  
//
//  Created by 若江照仁 on 2023/01/17.
//

import XCTest
@testable import Core
@testable import FeatureSelectLevel

final class ViewModelTests: XCTestCase {
    enum SelectLevelUseCaseStub: SelectLevelUseCase {
        static func fetchGameRecord(id: Core.LevelSelectorID) async throws -> Core.GameRecord? {
            if id == .colorBasic1 {
                return .init(id: id)
            } else {
                return nil
            }
        }
    }
    
    @MainActor
    func test初期化後に非同期でgameRecordsを取得() async throws {
        let viewModel = SelectLevelViewModelImpl<VoiceQuizLevelSelectorDummy, SelectLevelUseCaseStub>()
        XCTAssertEqual(viewModel.gameRecords, [:], "初期化と同期状態ではgameRecordsが空")
        _ = await viewModel.initialRefreshTask?.result
        XCTAssertEqual(viewModel.gameRecords, [.colorBasic1:.init(id: .colorBasic1)], "initialRefreshTask後gameRecordsは.colorBasic1のみ")
    }
        
    @MainActor
    func testレベルの選択と選択解除() async throws {
        let viewModel = SelectLevelViewModelImpl<VoiceQuizLevelSelectorDummy, SelectLevelUseCaseStub>()
        
        _ = await viewModel.selectGenerator(generator: viewModel.generators.first).result
        XCTAssertEqual(viewModel.selectedGenerator?.id, viewModel.generators.first?.id, "一つ目選択したら一つ目が選択状態")
        
        _ = await viewModel.selectGenerator(generator: viewModel.generators.last).result
        XCTAssertEqual(viewModel.selectedGenerator?.id, viewModel.generators.last?.id, "最後を選択したら最後が選択状態")
        
        _ = await viewModel.dismissGame().result
        XCTAssertNil(viewModel.selectedGenerator, "dismiss呼ばれたら未選択状態")
    }
}
