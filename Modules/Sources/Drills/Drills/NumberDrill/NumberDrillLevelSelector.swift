//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import Foundation
import Core

public enum NumberDrillLevelSelector: DrillLevelSelector {
    public typealias Drill = NumberDrill
    case dice123
    case dice456
    case diceAll
    case finger
    case numeral0123
    case numeral4567
    case numeral8910
    case numeralAll
    case advanced1
    case advanced2
    case advanced3
    case challenge
    
    public static var previewDrill: Drill {
        .init(options: [.numeral7, .finger2, .dice6, .numeral10])
    }
    
    public var generator: DrillGenerator<Drill> {
        switch self {
        case .dice123:
            return .init(
                id: .numberDice123,
                nextID: .numberDice456,
                title: "1~3",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.dice1, .dice2, .dice3], count: 10) },
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
        case .dice456:
            return .init(
                id: .numberDice456,
                nextID: .numberDiceAll,
                title: "4~6",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.dice4, .dice5, .dice6], count: 10) },
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
        case .diceAll:
            return .init(
                id: .numberDiceAll,
                nextID: .numberFinger,
                title: "1~6",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.dice1, .dice2, .dice3, .dice4, .dice5, .dice6], count: 10) },
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
            
        case .finger:
            return .init(
                id: .numberFinger,
                nextID: .numberNumeral0123,
                title: L10n.Number.Level.finger,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.finger1, .finger2, .finger3, .finger4, .finger5], count: 10) },
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
        case .numeral0123:
            return .init(
                id: .numberNumeral0123,
                nextID: .numberNumeral4567,
                title: "\(L10n.Number.Drill.title) 0~3",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.numeral0, .numeral1, .numeral2, .numeral3], count: 10) },
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
        case .numeral4567:
            return .init(
                id: .numberNumeral4567,
                nextID: .numberNumeral8910,
                title: "\(L10n.Number.Drill.title) 4~7",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.numeral4, .numeral5, .numeral6, .numeral7], count: 10) },
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
        case .numeral8910:
            return .init(
                id: .numberNumeral8910,
                nextID: .numberNumeralAll,
                title: "\(L10n.Number.Drill.title) 8~10",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.numeral8, .numeral9, .numeral10], count: 10) },
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
        case .numeralAll:
            return .init(
                id: .numberNumeralAll,
                nextID: .numberAdvanced1,
                title: "\(L10n.Number.Drill.title) 0~10",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.numeral0, .numeral1, .numeral2, .numeral3, .numeral4, .numeral5, .numeral6 , .numeral7 ,.numeral8, .numeral9, .numeral10].shuffled().prefix(4).toArray()) } },
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
                id: .numberAdvanced1,
                nextID: .numberAdvanced2,
                title: L10n.Common.Level.advanced1,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .init(options: NumberDrillOption.randomUniqueNumberOptions(of: 4)) } },
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
                id: .numberAdvanced2,
                nextID: .numberAdvanced3,
                title: L10n.Common.Level.advanced2,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .init(options: NumberDrillOption.randomUniqueNumberOptions(of: 6)) } },
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
                id: .numberAdvanced3,
                nextID: .numberChallenge,
                title: L10n.Common.Level.advanced3,
                requirements: L10n.Common.Level.requirementsFormat(15, 60),
                generate: { (0..<15).map { _ in .init(options: NumberDrillOption.randomUniqueNumberOptions(of: 9)) } },
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
                id: .numberChallenge,
                nextID: nil,
                title: L10n.Common.Level.challenge,
                requirements: "\(L10n.Common.Level.requirementsFormat(20, 60))(\(L10n.Common.Level.noMistakes))",
                generate: { (0..<20).map { _ in .init(options: NumberDrillOption.randomUniqueNumberOptions(of: 9)) } },
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

