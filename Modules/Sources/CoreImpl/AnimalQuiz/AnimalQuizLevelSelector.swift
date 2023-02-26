//
//  AnimalQuizLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/02/25.
//

import Core

public enum AnimalQuizLevelSelector: VoiceQuizLevelSelector {
    public typealias Quiz = AnimalQuiz
    case funny1
    case funny2
    case funny3
    case funny4
    case animal1
    case animal2
    case animal3
    case animal4
    case animal5
    case bird
    case reptile
    case marineLife
    case insect
    case all1
    case all2
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .funny1:
            return .init(
                id: 7,
                nextID: 8,
                title: "かわいい動物たち 1",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[0..<4].shuffled()) } },
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
        case .funny2:
            return .init(
                id: 8,
                nextID: 9,
                title: "かわいい動物たち 2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[0..<6].shuffled()) } },
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
        case .funny3:
            return .init(
                id: 9,
                nextID: 10,
                title: "かわいい動物たち 3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[0..<9].shuffled()) } },
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
        case .funny4:
            return .init(
                id: 10,
                nextID: 11,
                title: "かわいい動物たち 4",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[0..<12].shuffled()) } },
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
        case .animal1:
            return .init(
                id: 11,
                nextID: 12,
                title: "いろんな動物たち 1",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[12..<16].shuffled()) } },
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
        case .animal2:
            return .init(
                id: 12,
                nextID: 13,
                title: "いろんな動物たち 2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[12..<18].shuffled()) } },
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
        case .animal3:
            return .init(
                id: 13,
                nextID: 14,
                title: "いろんな動物たち 3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[12..<21].shuffled()) } },
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
        case .animal4:
            return .init(
                id: 14,
                nextID: 15,
                title: "いろんな動物たち 4",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[12..<24].shuffled()) } },
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
        case .animal5:
            return .init(
                id: 15,
                nextID: 20,
                title: "いろんな動物たち 5",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[12..<28].shuffled()) } },
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
        case .bird:
            return .init(
                id: 16,
                nextID: 17,
                title: "鳥たち",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[28..<34].shuffled()) } },
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
        case .reptile:
            return .init(
                id: 17,
                nextID: 18,
                title: "爬虫類たち",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[34..<38].shuffled()) } },
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
        case .marineLife:
            return .init(
                id: 18,
                nextID: 19,
                title: "海の生き物たち",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[38..<42].shuffled()) } },
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
        case .insect:
            return .init(
                id: 19,
                nextID: nil,
                title: "虫たち",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: AnimalQuizOption.allCases[42..<48].shuffled()) } },
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
        case .all1:
            return .init(
                id: 20,
                nextID: 21,
                title: "いろんな生き物",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in AnimalQuiz(options: Array(AnimalQuizOption.allCases[12..<48].shuffled()[0..<16])) } },
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
        case .all2:
            return .init(
                id: 21,
                nextID: 22,
                title: "いろんな生き物 2",
                requirements: "60秒以内に20問正解（ノーミス）",
                quizzes: { (0..<20).map { _ in AnimalQuiz(options: Array(AnimalQuizOption.allCases[12..<48].shuffled()[0..<16])) } },
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
        }
    }
}
