//
//  ColorQuizLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation
import Core

public enum ColorQuizLevelSelector: VoiceQuizLevelSelector {
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
                id: .colorLevel1,
                nextID: .colorLevel2,
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
                id: .colorLevel2,
                nextID: .colorLevel3,
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
                id: .colorLevel3,
                nextID: .colorLevel4,
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
                id: .colorLevel4,
                nextID: .colorLevel5,
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
                id: .colorLevel5,
                nextID: .colorLevel6,
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
                id: .colorLevel6,
                nextID: .colorLevel7,
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
                id: .colorLevel7,
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
