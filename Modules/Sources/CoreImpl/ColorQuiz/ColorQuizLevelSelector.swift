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
    case basic1
    case basic2
    case basic3
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case challenge
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .basic1:
            return .init(
                id: .colorBasic1,
                nextID: .colorBasic2,
                title: "基本1",
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
                    return time <= 20
                }
            )
        case .basic2:
            return .init(
                id: .colorBasic2,
                nextID: .colorBasic3,
                title: "基本2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz(options: [.white, .black, .lightBlue, .pink].shuffled()) } },
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
        case .basic3:
            return .init(
                id: .colorBasic3,
                nextID: .colorAdvanced1,
                title: "基本3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in ColorQuiz(options: [.orange, .purple, .gray, .brown].shuffled()) } },
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
                id: .colorAdvanced1,
                nextID: .colorAdvanced2,
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
                id: .colorAdvanced2,
                nextID: .colorAdvanced3,
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
                id: .colorAdvanced3,
                nextID: .colorAdvanced4,
                title: "応用3",
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
        case .advanced4:
            return .init(
                id: .colorAdvanced4,
                nextID: .colorChallenge,
                title: "応用4",
                requirements: "60秒以内に15問正解",
                quizzes: { (0..<15).map { _ in .random(by: 12) } },
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
        case .challenge:
            return .init(
                id: .colorChallenge,
                nextID: nil,
                title: "チャレンジ",
                requirements: "60秒以内に20問正解（ノーミス）",
                quizzes: { (0..<20).map { _ in .random(by: 12) } },
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
