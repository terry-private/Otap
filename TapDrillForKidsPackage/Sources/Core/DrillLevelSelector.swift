//
//  DrillLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation

public protocol DrillLevelSelector: Hashable, Identifiable, CaseIterable {
    associatedtype Drill: CoreDrill
    
    var generator: DrillGenerator<Drill> { get }
    static var previewDrill: Drill { get }
}

public extension DrillLevelSelector {
    var id: DrillGenerator<Drill>.ID {
        generator.id
    }
    
    func coveredDrills(from options: [Drill.Option], count: Int) -> [Drill] {
        (0..<count)
            .map { index in
                .init(
                    options: options.shuffled(),
                    answer: options[index < options.count ? index : (0..<options.count).randomElement() ?? 0]
                )
            }
            .shuffled()
    }
}

#if DEBUG
public enum DrillLevelSelectorDummy: DrillLevelSelector {
    public typealias Drill = DrillDummy
    
    case level1
    case level2
    
    public static var previewDrill: DrillDummy {
        DrillLevelSelectorDummy.level1.generator.previewDrill
    }
    
    public var generator: DrillGenerator<DrillDummy> {
        switch self {
        case .level1:
            return .init(
                id: .colorBasic1,
                nextID: .colorBasic2,
                title: "レベル1",
                requirements: "30秒以内に10問正解",
                generate: { (0..<10).map { _ in .random(by: 4) } },
                timeLimit: 30,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time < 20
                }
            )
        case .level2:
            return .init(
                id: .colorBasic2,
                nextID: nil,
                title: "レベル2",
                requirements: "30秒以内に10問正解",
                generate: { (0..<10).map { _ in .random(by: 6) } },
                timeLimit: 30,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time < 20
                }
            )
        }
    }
    
}
#endif
