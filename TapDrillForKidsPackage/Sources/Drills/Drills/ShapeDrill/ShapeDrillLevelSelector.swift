//
//  ShapeDrillLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Foundation
import Core

public enum ShapeDrillLevelSelector: DrillLevelSelector {
    public typealias Drill = ShapeDrill
    case basic1
    case basic2
    case basic3
    case advanced1
    case advanced2
    case challenge
    
    public static var previewDrill: Drill {
        .init(options: [.circle, .triangle, .heart, .star])
    }
    
    public var generator: DrillGenerator<Drill> {
        switch self {
        case .basic1:
            return .init(
                id: .shapeBasic1,
                nextID: .shapeBasic2,
                title: L10n.Common.Level.basic1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.circle, .cross], count: 10) },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: L10n.Common.Level.clear) { time, missCount in
                    return true
                },
                star2: .init(description: L10n.Common.Level.noMistakes) { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: L10n.Common.Level.limitFormat(20)) { time, missCount in
                    return time <= 20
                }
            )
        case .basic2:
            return .init(
                id: .shapeBasic2,
                nextID: .shapeBasic3,
                title: L10n.Common.Level.basic2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.circle, .triangle, .square], count: 10) },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: L10n.Common.Level.clear) { time, missCount in
                    return true
                },
                star2: .init(description: L10n.Common.Level.noMistakes) { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: L10n.Common.Level.limitFormat(20)) { time, missCount in
                    return time <= 20
                }
            )
        case .basic3:
            return .init(
                id: .shapeBasic3,
                nextID: .shapeAdvanced1,
                title: L10n.Common.Level.basic3,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.heart, .star], count: 10) },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: L10n.Common.Level.clear) { time, missCount in
                    return true
                },
                star2: .init(description: L10n.Common.Level.noMistakes) { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: L10n.Common.Level.limitFormat(20)) { time, missCount in
                    return time <= 20
                }
            )
        case .advanced1:
            return .init(
                id: .shapeAdvanced1,
                nextID: .shapeAdvanced2,
                title: L10n.Common.Level.advanced1,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .random(by: 4) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: L10n.Common.Level.clear) { time, missCount in
                    return true
                },
                star2: .init(description: L10n.Common.Level.noMistakes) { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: L10n.Common.Level.limitFormat(30)) { time, missCount in
                    return time <= 30
                }
            )
        case .advanced2:
            return .init(
                id: .shapeAdvanced2,
                nextID: .shapeChallenge,
                title: L10n.Common.Level.advanced2,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .random(by: 6) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: L10n.Common.Level.clear) { time, missCount in
                    return true
                },
                star2: .init(description: L10n.Common.Level.noMistakes) { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: L10n.Common.Level.limitFormat(30)) { time, missCount in
                    return time <= 30
                }
            )
        case .challenge:
            return .init(
                id: .shapeChallenge,
                nextID: nil,
                title: L10n.Common.Level.challenge,
                requirements: "\(L10n.Common.Level.requirementsFormat(20, 60))(\(L10n.Common.Level.noMistakes))",
                generate: { (0..<20).map { _ in .random(by: 6) } },
                timeLimit: 60,
                penalty: .gameOver,
                star1: .init(description: L10n.Common.Level.clear) { time, missCount in
                    return true
                },
                star2: .init(description: L10n.Common.Level.noMistakes) { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: L10n.Common.Level.limitFormat(30)) { time, missCount in
                    return time <= 30
                }
            )
        }
    }
}
