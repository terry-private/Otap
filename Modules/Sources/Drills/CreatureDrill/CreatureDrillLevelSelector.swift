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
                title: "基本動物1",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.dog🐕, .cat🐈, .pig🐖, .rabbit🐇].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .animal2:
            return .init(
                id: .creatureAnimal2,
                nextID: .creatureAnimal3,
                title: "基本動物2",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.elephant🐘, .giraffe🦒, .chipmunk🐿️, .cow🐄].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .animal3:
            return .init(
                id: .creatureAnimal3,
                nextID: .creatureAnimal4,
                title: "基本動物3",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.horse🐎, .monkey🐒, .mouse🐁, .tiger🐅].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .animal4:
            return .init(
                id: .creatureAnimal4,
                nextID: .creatureBird,
                title: "基本動物4",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.zebra🦓, .camel🐪, .kangaroo🦘, .rhinoceros🦏].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .bird:
            return .init(
                id: .creatureBird,
                nextID: .creatureReptile,
                title: "鳥",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.rooster🐓, .owl🦉, .flamingo🦩, .swan🦢, .duck🦆, .bat🦇].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .reptile:
            return .init(
                id: .creatureReptile,
                nextID: .creatureMarineLife,
                title: "爬虫類",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.turtle🐢, .crocodile🐊, .lizard🦎, .snake🐍].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .marineLife:
            return .init(
                id: .creatureMarineLife,
                nextID: .creatureInsect,
                title: "海の生き物",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.whale🐋, .dolphin🐬, .shark🦈, .octopus🐙].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .insect:
            return .init(
                id: .creatureInsect,
                nextID: .creatureAdvanced1,
                title: "虫",
                requirements: "60秒以内に10問正解",
                generate: { (0..<10).map { _ in .init(options: [.bug🐛, .butterfly🦋, .ant🐜, .honeybee🐝, .ladyBeetle🐞, .spider🕷].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time <= 20
                }
            )
        case .advanced1:
            return .init(
                id: .creatureAdvanced1,
                nextID: .creatureAdvanced2,
                title: "応用1",
                requirements: "60秒以内に15問正解",
                generate: { (0..<15).map { _ in .random(by: 4) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time <= 30
                }
            )
        case .advanced2:
            return .init(
                id: .creatureAdvanced2,
                nextID: .creatureAdvanced3,
                title: "応用2",
                requirements: "60秒以内に15問正解",
                generate: { (0..<15).map { _ in .random(by: 6) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time <= 30
                }
            )
        case .advanced3:
            return .init(
                id: .creatureAdvanced3,
                nextID: .creatureAdvanced4,
                title: "応用3",
                requirements: "60秒以内に15問正解",
                generate: { (0..<15).map { _ in .random(by: 9) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time <= 30
                }
            )
        case .advanced4:
            return .init(
                id: .creatureAdvanced4,
                nextID: .creatureAdvanced5,
                title: "応用4",
                requirements: "60秒以内に15問正解",
                generate: { (0..<15).map { _ in .random(by: 12) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time <= 30
                }
            )
        case .advanced5:
            return .init(
                id: .creatureAdvanced5,
                nextID: .creatureChallenge,
                title: "応用5",
                requirements: "60秒以内に15問正解",
                generate: { (0..<15).map { _ in .random(by: 16) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time <= 30
                }
            )
        case .challenge:
            return .init(
                id: .creatureChallenge,
                nextID: nil,
                title: "チャレンジ",
                requirements: "60秒以内に20問正解",
                generate: { (0..<20).map { _ in .random(by: 16) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time <= 30
                }
            )
        }
    }
}
