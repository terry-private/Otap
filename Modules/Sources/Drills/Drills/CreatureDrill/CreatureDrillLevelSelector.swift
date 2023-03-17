//
//  CreatureDrillLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import Core

public enum CreatureDrillLevelSelector: DrillLevelSelector {
    public typealias Drill = CreatureDrill
    case animal1
    case animal2
    case animal3
    case animal4
    case bird
    case reptile
    case marineLife
    case insect
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case advanced5
    case challenge
    
    public static var previewDrill: CreatureDrill {
        .init(options: [.giraffe🦒, .rooster🐓, .ladyBeetle🐞, .dolphin🐬])
    }
    
    public var generator: DrillGenerator<Drill> {
        switch self {
        case .animal1:
            return .init(
                id: .creatureAnimal1,
                nextID: .creatureAnimal2,
                title: L10n.Creature.Level.animal1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.dog🐕, .cat🐈, .pig🐖, .rabbit🐇].shuffled()) } },
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
        case .animal2:
            return .init(
                id: .creatureAnimal2,
                nextID: .creatureAnimal3,
                title: L10n.Creature.Level.animal2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.elephant🐘, .giraffe🦒, .chipmunk🐿️, .cow🐄].shuffled()) } },
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
        case .animal3:
            return .init(
                id: .creatureAnimal3,
                nextID: .creatureAnimal4,
                title: L10n.Creature.Level.animal3,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.horse🐎, .monkey🐒, .mouse🐁, .tiger🐅].shuffled()) } },
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
        case .animal4:
            return .init(
                id: .creatureAnimal4,
                nextID: .creatureBird,
                title: L10n.Creature.Level.animal4,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.zebra🦓, .camel🐪, .kangaroo🦘, .rhinoceros🦏].shuffled()) } },
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
        case .bird:
            return .init(
                id: .creatureBird,
                nextID: .creatureReptile,
                title: L10n.Creature.Level.bird,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.rooster🐓, .owl🦉, .flamingo🦩, .swan🦢, .duck🦆, .bat🦇].shuffled()) } },
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
        case .reptile:
            return .init(
                id: .creatureReptile,
                nextID: .creatureMarineLife,
                title: L10n.Creature.Level.reptile,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.turtle🐢, .crocodile🐊, .lizard🦎, .snake🐍].shuffled()) } },
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
        case .marineLife:
            return .init(
                id: .creatureMarineLife,
                nextID: .creatureInsect,
                title: L10n.Creature.Level.marineLife,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.whale🐋, .dolphin🐬, .shark🦈, .octopus🐙].shuffled()) } },
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
        case .insect:
            return .init(
                id: .creatureInsect,
                nextID: .creatureAdvanced1,
                title: L10n.Creature.Level.insect,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.bug🐛, .butterfly🦋, .ant🐜, .honeybee🐝, .ladyBeetle🐞, .spider🕷].shuffled()) } },
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
                id: .creatureAdvanced1,
                nextID: .creatureAdvanced2,
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
                id: .creatureAdvanced2,
                nextID: .creatureAdvanced3,
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
                id: .creatureAdvanced3,
                nextID: .creatureAdvanced4,
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
                id: .creatureAdvanced4,
                nextID: .creatureAdvanced5,
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
                id: .creatureAdvanced5,
                nextID: .creatureChallenge,
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
                id: .creatureChallenge,
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
