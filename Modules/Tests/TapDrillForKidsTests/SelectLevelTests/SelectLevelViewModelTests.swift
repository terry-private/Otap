//
//  ViewModelTests.swift
//  
//
//  Created by 若江照仁 on 2023/01/17.
//

import XCTest
@testable import Core
@testable import FeatureSelectLevel

final class SelectLevelViewModelTests: XCTestCase {
    enum SelectLevelUseCaseStub: SelectLevelUseCase {
        static func fetchDrillRecord(id: Core.LevelSelectorID) async throws -> DrillRecord? {
            if id == .colorBasic1 {
                return .init(id: id)
            } else {
                return nil
            }
        }
    }
    
    @MainActor
    func test初期化後に非同期でdrillRecordsを取得() async throws {
        let viewModel = SelectLevelViewModelImpl<DrillLevelSelectorDummy, SelectLevelUseCaseStub>()
        XCTAssertEqual(viewModel.drillRecords, [:], "初期化と同期状態ではdrillRecordsが空")
        _ = await viewModel.initialRefreshTask?.result
        XCTAssertEqual(viewModel.drillRecords, [.colorBasic1:.init(id: .colorBasic1)], "initialRefreshTask後drillRecordsは.colorBasic1のみ")
    }
        
    @MainActor
    func testレベルの選択と選択解除() async throws {
        let viewModel = SelectLevelViewModelImpl<DrillLevelSelectorDummy, SelectLevelUseCaseStub>()
        
        _ = await viewModel.selectGenerator(generator: viewModel.generators.first).result
        XCTAssertEqual(viewModel.selectedGenerator?.id, viewModel.generators.first?.id, "一つ目選択したら一つ目が選択状態")
        
        _ = await viewModel.selectGenerator(generator: viewModel.generators.last).result
        XCTAssertEqual(viewModel.selectedGenerator?.id, viewModel.generators.last?.id, "最後を選択したら最後が選択状態")
        
        _ = await viewModel.dismissDrill().result
        XCTAssertNil(viewModel.selectedGenerator, "dismiss呼ばれたら未選択状態")
    }
}
