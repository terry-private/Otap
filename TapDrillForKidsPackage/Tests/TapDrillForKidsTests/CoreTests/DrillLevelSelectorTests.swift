//
//  DrillLevelSelectorTests.swift
//  
//
//  Created by 若江照仁 on 2023/03/29.
//

import XCTest
@testable import Core

final class DrillLevelSelectorTests: XCTestCase {
    func testCoveredDrillsTests() throws {
        let dummyOptions = DrillLevelSelectorDummy.Drill.Option.allCases
        let coveredDrillAnswers = DrillLevelSelectorDummy.level1.coveredDrills(from: dummyOptions, count: dummyOptions.count).map { $0.answer }
        let uniqueAnswersCount = Set(coveredDrillAnswers).count
        
        XCTAssertEqual(dummyOptions.count, uniqueAnswersCount, "答えが全て違うなら選択数と一意となる答えの数が同じになるはず")
        
    }
}
