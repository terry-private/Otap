//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import Foundation
import Core

public enum NumberQuizLevelSelector: VoiceQuizLevelSelector {
    public typealias Quiz = NumberQuiz
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
    
    public static var previewQuiz: Quiz {
        .init(options: [.numeral7, .finger2, .dice6, .numeral10])
    }
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .dice123:
            return .init(
                id: .numberDice123,
                nextID: .numberDice456,
                title: "123",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.dice1, .dice2, .dice3].shuffled()) } },
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
        case .dice456:
            return .init(
                id: .numberDice456,
                nextID: .numberDiceAll,
                title: "456",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.dice4, .dice5, .dice6].shuffled()) } },
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
        case .diceAll:
            return .init(
                id: .numberDiceAll,
                nextID: .numberFinger,
                title: "1~6",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.dice1, .dice2, .dice3, .dice4, .dice5, .dice6].prefix(4).shuffled()) } },
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
            
        case .finger:
            return .init(
                id: .numberFinger,
                nextID: .numberNumeral0123,
                title: "指",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.finger1, .finger2, .finger3, .finger4, .finger5].shuffled().prefix(4).toArray()) } },
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
        case .numeral0123:
            return .init(
                id: .numberNumeral0123,
                nextID: .numberNumeral4567,
                title: "数字0~3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.numeral0, .numeral1, .numeral2, .numeral3].shuffled()) } },
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
        case .numeral4567:
            return .init(
                id: .numberNumeral4567,
                nextID: .numberNumeral8910,
                title: "数字4~7",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.numeral4, .numeral5, .numeral6, .numeral7].shuffled()) } },
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
        case .numeral8910:
            return .init(
                id: .numberNumeral8910,
                nextID: .numberNumeralAll,
                title: "数字8~10",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.numeral8, .numeral9, .numeral10].shuffled()) } },
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
        case .numeralAll:
            return .init(
                id: .numberNumeralAll,
                nextID: .numberAdvanced1,
                title: "数字0~10",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.numeral0, .numeral1, .numeral2, .numeral3, .numeral4, .numeral5, .numeral6 , .numeral7 ,.numeral8, .numeral9, .numeral10].shuffled().prefix(4).toArray()) } },
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
                id: .numberAdvanced1,
                nextID: .numberAdvanced2,
                title: "応用1",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .init(options: NumberQuizOption.randomUniqueNumberOptions(of: 4)) } },
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
                id: .numberAdvanced2,
                nextID: .numberAdvanced3,
                title: "応用2",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .init(options: NumberQuizOption.randomUniqueNumberOptions(of: 6)) } },
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
                id: .numberAdvanced3,
                nextID: .numberChallenge,
                title: "応用3",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .init(options: NumberQuizOption.randomUniqueNumberOptions(of: 9)) } },
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
                id: .numberChallenge,
                nextID: nil,
                title: "チャレンジ",
                requirements: "60秒以内に20問正解（ノーミス）",
                quizzes: { (0..<20).map { _ in .init(options: NumberQuizOption.randomUniqueNumberOptions(of: 9)) } },
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
        }
    }
}

