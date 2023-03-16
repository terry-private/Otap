//
//  FruitsAndVegetablesDrillLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/03.
//

import Core

public enum FruitsAndVegetablesDrillLevelSelector: DrillLevelSelector {
    public typealias Drill = FruitsAndVegetablesDrill
    case vegetable1
    case vegetable2
    case vegetable3
    case fruit1
    case fruit2
    case fruit3
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case advanced5
    case challenge
    
    public static var previewDrill: Drill {
        .init(options: [.tomato🍅, .banana🍌, .grape🍇, .broccoli🥦])
    }
    
    public var generator: DrillGenerator<Drill> {
        switch self {
        case .vegetable1:
            return .init(
                id: .fruitsAndVegetablesVegetable1,
                nextID: .fruitsAndVegetablesVegetable2,
                title: L10n.FruitsAndVegetables.Level.vegetable1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.tomato🍅, .eggplant🍆, .potato🥔, .carrot🥕].shuffled()) } },
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
        case .vegetable2:
            return .init(
                id: .fruitsAndVegetablesVegetable2,
                nextID: .fruitsAndVegetablesVegetable3,
                title: L10n.FruitsAndVegetables.Level.vegetable2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.onion🧅, .cucumber🥒, .corn🌽, .broccoli🥦].shuffled()) } },
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
        case .vegetable3:
            return .init(
                id: .fruitsAndVegetablesVegetable3,
                nextID: .fruitsAndVegetablesFruit1,
                title: L10n.FruitsAndVegetables.Level.vegetable3,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.sweetPotato🍠, .greenBellPepper🫑, .chestnuts🌰, .mushrooms🍄].shuffled()) } },
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
        case .fruit1:
            return .init(
                id: .fruitsAndVegetablesFruit1,
                nextID: .fruitsAndVegetablesFruit2,
                title: L10n.FruitsAndVegetables.Level.fruit1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.orange🍊, .apple🍎, .grape🍇, .kiwi🥝].shuffled()) } },
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
        case .fruit2:
            return .init(
                id: .fruitsAndVegetablesFruit2,
                nextID: .fruitsAndVegetablesFruit3,
                title: L10n.FruitsAndVegetables.Level.fruit2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.watermelon🍉, .lemon🍋, .peach🍑, .strawberry🍓].shuffled()) } },
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
        case .fruit3:
            return .init(
                id: .fruitsAndVegetablesFruit3,
                nextID: .fruitsAndVegetablesAdvanced1,
                title: L10n.FruitsAndVegetables.Level.fruit3,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.banana🍌, .pineapple🍍, .melon🍈, .blueberry🫐].shuffled()) } },
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
                id: .fruitsAndVegetablesAdvanced1,
                nextID: .fruitsAndVegetablesAdvanced2,
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
                id: .fruitsAndVegetablesAdvanced2,
                nextID: .fruitsAndVegetablesAdvanced3,
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
        case .advanced3:
            return .init(
                id: .fruitsAndVegetablesAdvanced3,
                nextID: .fruitsAndVegetablesAdvanced4,
                title: L10n.Common.Level.advanced3,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .random(by: 9) } },
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
        case .advanced4:
            return .init(
                id: .fruitsAndVegetablesAdvanced4,
                nextID: .fruitsAndVegetablesAdvanced5,
                title: L10n.Common.Level.advanced4,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .random(by: 12) } },
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
        case .advanced5:
            return .init(
                id: .fruitsAndVegetablesAdvanced5,
                nextID: .fruitsAndVegetablesChallenge,
                title: L10n.Common.Level.advanced5,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .random(by: 16) } },
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
                id: .fruitsAndVegetablesChallenge,
                nextID: nil,
                title: L10n.Common.Level.challenge,
                requirements: "\(L10n.Common.Level.requirementsFormat(20, 60))(\(L10n.Common.Level.noMistakes))",
                generate: { (0..<20).map { _ in .random(by: 16) } },
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
