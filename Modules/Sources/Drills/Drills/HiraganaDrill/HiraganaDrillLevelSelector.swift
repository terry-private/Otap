//
//  HiraganaDrillLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import Foundation
import Core

public enum HiraganaDrillLevelSelector: DrillLevelSelector {
    public typealias Drill = HiraganaDrill
    case あ行
    case か行
    case review1
    case さ行
    case review2
    case た行
    case review3
    case な行
    case review4
    case は行
    case review5
    case ま行
    case review6
    case や行
    case review7
    case ら行
    case review8
    case わ行
    case review9
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case advanced5
    case challenge
    
    public static var previewDrill: Drill {
        .init(options: [.ひ, .ら, .か, .な])
    }
    
    public var generator: DrillGenerator<Drill> {
        switch self {
        case .あ行:
            return .init(
                id: .hiraganaあ行,
                nextID: .hiraganaか行,
                title: "あ\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.あ行.shuffled()) } },
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
        case .か行:
            return .init(
                id: .hiraganaか行,
                nextID: .hiraganaReview1,
                title: "か\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.か行.shuffled()) } },
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
        case .review1:
            return .init(
                id: .hiraganaReview1,
                nextID: .hiraganaさ行,
                title: "\(L10n.Hiragana.review)（あ~か\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review1) } },
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
            
        case .さ行:
            return .init(
                id: .hiraganaさ行,
                nextID: .hiraganaReview2,
                title: "さ\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.さ行.shuffled()) } },
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
        case .review2:
            return .init(
                id: .hiraganaReview2,
                nextID: .hiraganaた行,
                title: "\(L10n.Hiragana.review)（あ〜さ\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review2) } },
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
        case .た行:
            return .init(
                id: .hiraganaた行,
                nextID: .hiraganaReview3,
                title: "た\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.た行.shuffled()) } },
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
        case .review3:
            return .init(
                id: .hiraganaReview3,
                nextID: .hiraganaな行,
                title: "\(L10n.Hiragana.review)（あ〜た\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review3) } },
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
        case .な行:
            return .init(
                id: .hiraganaな行,
                nextID: .hiraganaReview4,
                title: "な\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.な行.shuffled()) } },
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
        case .review4:
            return .init(
                id: .hiraganaReview4,
                nextID: .hiraganaは行,
                title: "\(L10n.Hiragana.review)（あ〜な\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review4) } },
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
        case .は行:
            return .init(
                id: .hiraganaは行,
                nextID: .hiraganaReview5,
                title: "は\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.は行.shuffled()) } },
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
        case .review5:
            return .init(
                id: .hiraganaReview5,
                nextID: .hiraganaま行,
                title: "\(L10n.Hiragana.review)（あ〜は\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review5) } },
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
        case .ま行:
            return .init(
                id: .hiraganaま行,
                nextID: .hiraganaReview6,
                title: "ま\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.ま行.shuffled()) } },
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
        case .review6:
            return .init(
                id: .hiraganaReview6,
                nextID: .hiraganaや行,
                title: "\(L10n.Hiragana.review)（あ〜ま\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review6) } },
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
        case .や行:
            return .init(
                id: .hiraganaや行,
                nextID: .hiraganaReview7,
                title: "や\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.や行.shuffled()) } },
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
        case .review7:
            return .init(
                id: .hiraganaReview7,
                nextID: .hiraganaら行,
                title: "\(L10n.Hiragana.review)（あ〜や\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review7) } },
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
        case .ら行:
            return .init(
                id: .hiraganaら行,
                nextID: .hiraganaReview8,
                title: "ら\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.ら行.shuffled()) } },
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
        case .review8:
            return .init(
                id: .hiraganaReview8,
                nextID: .hiraganaわ行,
                title: "\(L10n.Hiragana.review)（あ〜ら\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review8) } },
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
        case .わ行:
            return .init(
                id: .hiraganaわ行,
                nextID: .hiraganaReview9,
                title: "わ\(L10n.Hiragana.row)",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.わ行.shuffled()) } },
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
        case .review9:
            return .init(
                id: .hiraganaReview9,
                nextID: .hiraganaAdvanced1,
                title: "\(L10n.Hiragana.review)（あ〜わ\(L10n.Hiragana.row)）",
                requirements: L10n.Common.Level.requirementsFormat(10, 60),
                generate: { (0..<10).map { _ in .init(options: HiraganaDrillOption.review9) } },
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
                id: .hiraganaAdvanced1,
                nextID: .hiraganaAdvanced2,
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
                id: .hiraganaAdvanced2,
                nextID: .hiraganaAdvanced3,
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
                id: .hiraganaAdvanced3,
                nextID: .hiraganaAdvanced4,
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
                id: .hiraganaAdvanced4,
                nextID: .hiraganaAdvanced5,
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
                id: .hiraganaAdvanced5,
                nextID: .hiraganaChallenge,
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
                id: .hiraganaChallenge,
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

