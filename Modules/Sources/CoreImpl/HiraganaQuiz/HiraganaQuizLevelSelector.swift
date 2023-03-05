//
//  HiraganaQuizLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import Foundation
import Core

public enum HiraganaQuizLevelSelector: VoiceQuizLevelSelector {
    public typealias Quiz = HiraganaQuiz
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
    
    public static var previewQuiz: Quiz {
        .init(options: [.ひ, .ら, .か, .な])
    }
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .あ行:
            return .init(
                id: .hiraganaあ行,
                nextID: .hiraganaか行,
                title: "あ行",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.あ行.shuffled()) } },
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
        case .か行:
            return .init(
                id: .hiraganaか行,
                nextID: .hiraganaReview1,
                title: "か行",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.か行.shuffled()) } },
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
        case .review1:
            return .init(
                id: .hiraganaReview1,
                nextID: .hiraganaさ行,
                title: "復習（あ~か行）",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.review1) } },
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
            
        case .さ行:
            return .init(
                id: .hiraganaさ行,
                nextID: .hiraganaReview2,
                title: "さ行",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.さ行.shuffled()) } },
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
        case .review2:
            return .init(
                id: .hiraganaReview2,
                nextID: .hiraganaた行,
                title: "復習（あ〜さ行）",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.review2) } },
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
        case .た行:
            return .init(
                id: .hiraganaた行,
                nextID: .hiraganaReview3,
                title: "た行",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.た行.shuffled()) } },
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
        case .review3:
            return .init(
                id: .hiraganaReview3,
                nextID: .hiraganaな行,
                title: "復習（あ〜た行）",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.review3) } },
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
        case .な行:
            return .init(
                id: .hiraganaな行,
                nextID: .hiraganaReview4,
                title: "な行",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.な行.shuffled()) } },
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
        case .review4:
            return .init(
                id: .hiraganaReview4,
                nextID: .hiraganaは行,
                title: "復習（あ〜な行）",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .init(options: HiraganaQuizOption.review4) } },
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
        case .は行:
            return .init(
                id: .hiraganaは行,
                nextID: .hiraganaReview5,
                title: "は行",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.は行.shuffled()) } },
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
        case .review5:
            return .init(
                id: .hiraganaReview5,
                nextID: .hiraganaま行,
                title: "復習（あ〜は行）",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .init(options: HiraganaQuizOption.review5) } },
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
        case .ま行:
            return .init(
                id: .hiraganaま行,
                nextID: .hiraganaReview6,
                title: "ま行",
                requirements: "60秒以内に20問正解（ノーミス）",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.ま行.shuffled()) } },
                timeLimit: 60,
                penalty: .gameOver,
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
        case .review6:
            return .init(
                id: .hiraganaReview6,
                nextID: .hiraganaや行,
                title: "復習（あ〜ま行）",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.review6) } },
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
        case .や行:
            return .init(
                id: .hiraganaや行,
                nextID: .hiraganaReview7,
                title: "は行",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.や行.shuffled()) } },
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
        case .review7:
            return .init(
                id: .hiraganaReview7,
                nextID: .hiraganaら行,
                title: "復習（あ〜や行）",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.review7) } },
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
        case .ら行:
            return .init(
                id: .hiraganaら行,
                nextID: .hiraganaReview8,
                title: "ら行",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.ら行.shuffled()) } },
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
        case .review8:
            return .init(
                id: .hiraganaReview8,
                nextID: .hiraganaわ行,
                title: "復習（あ〜ら行）",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.review8) } },
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
        case .わ行:
            return .init(
                id: .hiraganaわ行,
                nextID: .hiraganaReview9,
                title: "わ行",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.わ行.shuffled()) } },
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
        case .review9:
            return .init(
                id: .hiraganaReview9,
                nextID: .hiraganaAdvanced1,
                title: "復習（あ〜わ行）",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: HiraganaQuizOption.review9) } },
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
        case .advanced1:
            return .init(
                id: .hiraganaAdvanced1,
                nextID: .hiraganaAdvanced2,
                title: "応用1",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .random(by: 4) } },
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
                id: .hiraganaAdvanced2,
                nextID: .hiraganaAdvanced3,
                title: "応用2",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .random(by: 6) } },
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
                id: .hiraganaAdvanced3,
                nextID: .hiraganaAdvanced4,
                title: "応用3",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .random(by: 9) } },
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
                id: .hiraganaAdvanced4,
                nextID: .hiraganaAdvanced5,
                title: "応用4",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .random(by: 12) } },
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
                id: .hiraganaAdvanced5,
                nextID: .hiraganaChallenge,
                title: "応用5",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .random(by: 16) } },
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
                id: .hiraganaChallenge,
                nextID: nil,
                title: "チャレンジ",
                requirements: "60秒以内に20問正解",
                quizzes: { (0..<20).map { _ in .random(by: 16) } },
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

