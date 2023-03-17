//
//  FunnyAnimalDrillLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import Core

public enum FunnyAnimalDrillLevelSelector: DrillLevelSelector {
    public typealias Drill = FunnyAnimalDrill
    case basic1
    case basic2
    case basic3
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case challenge
    
    public static var previewDrill: FunnyAnimalDrill {
        .init(options: [.dogFace🐶, .horseFace🐴, .pandaFace🐼, .lionFace🦁])
    }
    
    public var generator: DrillGenerator<Drill> {
        switch self {
        case .basic1:
            return .init(
                id: .funnyAnimalBasic1,
                nextID: .funnyAnimalBasic2,
                title: L10n.Common.Level.basic1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.dogFace🐶, .catFace🐱, .pigFace🐷, .rabbitFace🐰].shuffled()) } },
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
                id: .funnyAnimalBasic2,
                nextID: .funnyAnimalBasic3,
                title: L10n.Common.Level.basic2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.lionFace🦁, .cowFace🐮, .horseFace🐴, .mouseFace🐭].shuffled()) } },
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
                id: .funnyAnimalBasic3,
                nextID: .funnyAnimalAdvanced1,
                title: L10n.Common.Level.basic3,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: [.monkeyFace🐵, .pandaFace🐼, .tigerFace🐯, .bearFace🐻].shuffled()) } },
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
                id: .funnyAnimalAdvanced1,
                nextID: .funnyAnimalAdvanced2,
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
                id: .funnyAnimalAdvanced2,
                nextID: .funnyAnimalAdvanced3,
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
                id: .funnyAnimalAdvanced3,
                nextID: .funnyAnimalAdvanced4,
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
                id: .funnyAnimalAdvanced4,
                nextID: .funnyAnimalChallenge,
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
        case .challenge:
            return .init(
                id: .funnyAnimalChallenge,
                nextID: nil,
                title: L10n.Common.Level.challenge,
                requirements: "\(L10n.Common.Level.requirementsFormat(20, 60))(\(L10n.Common.Level.noMistakes))",
                generate: { (0..<20).map { _ in .random(by: 12) } },
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
