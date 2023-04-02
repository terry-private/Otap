//
//  NationalFlagDrillLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/24.
//

import Core

public enum NationalFlagDrillLevelSelector: DrillLevelSelector {
    public typealias Drill = NationalFlagDrill
    case asia1
    case asia2
    case asia3
    case asia4
    case asia5AndOceania
    case americas1
    case americas2
    case americas3
    case americas4
    case europe1
    case europe2
    case europe3
    case europe4
    case europe5
    case europe6
    case africa1
    case africa2
    case africa3
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case advanced5
    case challenge
    
    public static var previewDrill: NationalFlagDrill {
        .init(options: [.japan🇯🇵, .france🇫🇷, .unitedstate🇺🇸, .cameroun🇨🇲])
    }
    
    public var generator: DrillGenerator<Drill> {
        switch self {
        case .asia1:
            return .init(
                id: .nationalFlagAsia1,
                nextID: .nationalFlagAsia2,
                title: L10n.NationalFlag.Level.asia1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.japan🇯🇵, .korea🇰🇷, .china🇨🇳, .thailand🇹🇭], count: 10) },
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
        case .asia2:
            return .init(
                id: .nationalFlagAsia2,
                nextID: .nationalFlagAsia3,
                title: L10n.NationalFlag.Level.asia2AndOceania,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.india🇮🇳, .indonesia🇮🇩, .singapore🇸🇬, .bangladesh🇧🇩], count: 10) },
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
        case .asia3:
            return .init(
                id: .nationalFlagAsia3,
                nextID: .nationalFlagAsia4,
                title: L10n.NationalFlag.Level.asia2AndOceania,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.iraq🇮🇶, .iran🇮🇷, .cambodia🇰🇭, .saudiarabia🇸🇦], count: 10) },
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
        case .asia4:
            return .init(
                id: .nationalFlagAsia4,
                nextID: .nationalFlagAsia5AndOceania,
                title: L10n.NationalFlag.Level.asia2AndOceania,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.malaysia🇲🇾, .nepal🇳🇵, .philippines🇵🇭, .pakistan🇵🇰], count: 10) },
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
        case .asia5AndOceania:
            return .init(
                id: .nationalFlagAsia5AndOceania,
                nextID: .nationalFlagAmericas1,
                title: L10n.NationalFlag.Level.asia2AndOceania,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.turkey🇹🇷, .vietnam🇻🇳, .australia🇦🇺, .newzealand🇳🇿], count: 10) },
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
        case .americas1:
            return .init(
                id: .nationalFlagAmericas1,
                nextID: .nationalFlagAmericas2,
                title: L10n.NationalFlag.Level.americas1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.unitedstate🇺🇸, .canada🇨🇦, .mexico🇲🇽, .brazil🇧🇷], count: 10) },
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
        case .americas2:
            return .init(
                id: .nationalFlagAmericas2,
                nextID: .nationalFlagAmericas3,
                title: L10n.NationalFlag.Level.americas2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.argentina🇦🇷, .uruguay🇺🇾, .peru🇵🇪, .paraguay🇵🇾], count: 10) },
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
        case .americas3:
            return .init(
                id: .nationalFlagAmericas3,
                nextID: .nationalFlagAmericas4,
                title: L10n.NationalFlag.Level.americas2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.colombia🇨🇴, .jamaica🇯🇲, .chile🇨🇱, .cuba🇨🇺], count: 10) },
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
        case .americas4:
            return .init(
                id: .nationalFlagAmericas4,
                nextID: .nationalFlagEurope1,
                title: L10n.NationalFlag.Level.americas2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.costarica🇨🇷, .panama🇵🇦, .ecuador🇪🇨, .venezuela🇻🇪], count: 10) },
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
        case .europe1:
            return .init(
                id: .nationalFlagEurope1,
                nextID: .nationalFlagEurope2,
                title: L10n.NationalFlag.Level.europe1,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.unitedkingdom🇬🇧, .germany🇩🇪, .france🇫🇷, .italy🇮🇹], count: 10) },
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
        case .europe2:
            return .init(
                id: .nationalFlagEurope2,
                nextID: .nationalFlagEurope3,
                title: L10n.NationalFlag.Level.europe2,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.spain🇪🇸, .portugal🇵🇹, .russia🇷🇺, .netherlands🇳🇱], count: 10) },
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
        case .europe3:
            return .init(
                id: .nationalFlagEurope3,
                nextID: .nationalFlagEurope4,
                title: L10n.NationalFlag.Level.europe3,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.switzerland🇨🇭, .sweeden🇸🇪, .norway🇳🇴, .poland🇵🇱], count: 10) },
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
        case .europe4:
            return .init(
                id: .nationalFlagEurope4,
                nextID: .nationalFlagEurope5,
                title: L10n.NationalFlag.Level.europe4,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.belgium🇧🇪, .greece🇬🇷, .hungary🇭🇺, .ukraine🇺🇦], count: 10) },
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
        case .europe5:
            return .init(
                id: .nationalFlagEurope5,
                nextID: .nationalFlagEurope6,
                title: L10n.NationalFlag.Level.europe4,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.austria🇦🇹, .denmark🇩🇰, .finland🇫🇮, .ireland🇮🇪], count: 10) },
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
        case .europe6:
            return .init(
                id: .nationalFlagEurope6,
                nextID: .nationalFlagAfrica1,
                title: L10n.NationalFlag.Level.europe4,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.iceland🇮🇸, .croatia🇭🇷, .slovakia🇸🇰, .czech🇨🇿], count: 10) },
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
        case .africa1:
            return .init(
                id: .nationalFlagAfrica1,
                nextID: .nationalFlagAfrica2,
                title: L10n.NationalFlag.Level.africa,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.cameroun🇨🇲, .kenya🇰🇪, .nigeria🇳🇬, .southafrica🇿🇦], count: 10) },
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
        case .africa2:
            return .init(
                id: .nationalFlagAfrica2,
                nextID: .nationalFlagAfrica3,
                title: L10n.NationalFlag.Level.africa,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.senegal🇸🇳, .egypt🇪🇬, .ghana🇬🇭, .morocco🇲🇦], count: 10) },
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
        case .africa3:
            return .init(
                id: .nationalFlagAfrica3,
                nextID: .nationalFlagAdvanced1,
                title: L10n.NationalFlag.Level.africa,
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { coveredDrills(from: [.tunisia🇹🇳, .ethiopia🇪🇹, .algeria🇩🇿, .cotedIvoire🇨🇮], count: 10) },
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
                id: .nationalFlagAdvanced1,
                nextID: .nationalFlagAdvanced2,
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
                id: .nationalFlagAdvanced2,
                nextID: .nationalFlagAdvanced3,
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
                id: .nationalFlagAdvanced3,
                nextID: .nationalFlagAdvanced4,
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
                id: .nationalFlagAdvanced4,
                nextID: .nationalFlagAdvanced5,
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
                id: .nationalFlagAdvanced5,
                nextID: .nationalFlagChallenge,
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
                id: .nationalFlagChallenge,
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
