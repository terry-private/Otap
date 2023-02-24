//
//  ColorQuizCategory.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation
import Core

public enum ColorQuizCategory: VoiceQuizCategory {
    public typealias Quiz = ColorQuiz
    case level1
    case level2
    case level3
    case level4
    case level5
    case level6
    case level7
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .level1:
            return .init(
                id: 0,
                nextID: 1,
                title: "レベル1",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz(options: [.white, .black].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time < 20
                }
            )
        case .level2:
            return .init(
                id: 1,
                nextID: 2,
                title: "レベル2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz(options: [.red, .blue, .yellow].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time < 20
                }
            )
        case .level3:
            return .init(
                id: 2,
                nextID: 3,
                title: "レベル3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz(options: [.red, .blue, .yellow, .green].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time < 20
                }
            )
        case .level4:
            return .init(
                id: 3,
                nextID: 4,
                title: "レベル4",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz(options: [.red, .blue, .yellow, .green, .white, .black].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "20s以内") { time, missCount in
                    return time < 20
                }
            )
        case .level5:
            return .init(
                id: 4,
                nextID: 5,
                title: "レベル5",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz(options: [.red, .blue, .yellow, .green, .white, .black, .lightBlue, .orange, .pink].shuffled()) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time < 30
                }
            )
        case .level6:
            return .init(
                id: 5,
                nextID: 6,
                title: "レベル6",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz.random(by: 12) } },
                timeLimit: 60,
                penalty: .shuffle,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time < 30
                }
            )
        case .level7:
            return .init(
                id: 6,
                nextID: nil,
                title: "レベル7",
                requirements: "60秒以内に20問正解（ノーミス）",
                quizzes: { (0..<20).map { _ in ColorQuiz.random(by: 12) } },
                timeLimit: 60,
                penalty: .gameOver,
                star1: .init(description: "クリア") { time, missCount in
                    return true
                },
                star2: .init(description: "ノーミス") { time, missCount in
                    return missCount == 0
                },
                star3: .init(description: "30s以内") { time, missCount in
                    return time < 30
                }
            )
        }
    }
}
