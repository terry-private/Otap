//
//  ShapeQuizLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Foundation
import Core

public enum ShapeQuizLevelSelector: VoiceQuizLevelSelector {
    public typealias Quiz = ShapeQuiz
    case basic1
    case basic2
    case basic3
    case advanced1
    case advanced2
    case challenge
    
    public static var previewQuiz: Quiz {
        .init(options: [.circle, .triangle, .heart, .star])
    }
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .basic1:
            return .init(
                id: .shapeBasic1,
                nextID: .shapeBasic2,
                title: "基本1",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.circle, .cross].shuffled()) } },
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
                id: .shapeBasic2,
                nextID: .shapeBasic3,
                title: "基本2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.circle, .triangle, .square].shuffled()) } },
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
                id: .shapeBasic3,
                nextID: .shapeAdvanced1,
                title: "基本3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.heart, .star].shuffled()) } },
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
                id: .shapeAdvanced1,
                nextID: .shapeAdvanced2,
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
                id: .shapeAdvanced2,
                nextID: .shapeChallenge,
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
        case .challenge:
            return .init(
                id: .shapeChallenge,
                nextID: nil,
                title: "チャレンジ",
                requirements: "60秒以内に20問正解（ノーミス）",
                quizzes: { (0..<20).map { _ in .random(by: 6) } },
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
