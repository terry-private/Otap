//
//  FruitsAndVegetablesQuizLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/03.
//

import Core

public enum FruitsAndVegetablesQuizLevelSelector: VoiceQuizLevelSelector {
    public typealias Quiz = FruitsAndVegetablesQuiz
    case vegetable1
    case vegetable2
    case vegetable3
    case fruit1
    case fruit2
    case fruit3
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case advanced5
    case challenge
    
    public static var previewQuiz: Quiz {
        .init(options: [.tomato🍅, .banana🍌, .grape🍇, .broccoli🥦])
    }
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .vegetable1:
            return .init(
                id: .fruitsAndVegetablesVegetable1,
                nextID: .fruitsAndVegetablesVegetable2,
                title: "野菜1",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.tomato🍅, .eggplant🍆, .potato🥔, .carrot🥕].shuffled()) } },
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
        case .vegetable2:
            return .init(
                id: .fruitsAndVegetablesVegetable2,
                nextID: .fruitsAndVegetablesVegetable3,
                title: "野菜2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.onion🧅, .cucumber🥒, .corn🌽, .broccoli🥦].shuffled()) } },
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
        case .vegetable3:
            return .init(
                id: .fruitsAndVegetablesVegetable3,
                nextID: .fruitsAndVegetablesFruit1,
                title: "野菜3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.sweetPotato🍠, .greenBellPepper🫑, .chestnuts🌰, .mushrooms🍄].shuffled()) } },
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
        case .fruit1:
            return .init(
                id: .fruitsAndVegetablesFruit1,
                nextID: .fruitsAndVegetablesFruit2,
                title: "果物1",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.orange🍊, .apple🍎, .grape🍇, .kiwi🥝].shuffled()) } },
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
        case .fruit2:
            return .init(
                id: .fruitsAndVegetablesFruit2,
                nextID: .fruitsAndVegetablesFruit3,
                title: "果物2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.watermelon🍉, .lemon🍋, .peach🍑, .strawberry🍓].shuffled()) } },
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
        case .fruit3:
            return .init(
                id: .fruitsAndVegetablesFruit3,
                nextID: .fruitsAndVegetablesAdvanced1,
                title: "果物3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.banana🍌, .pineapple🍍, .melon🍈, .blueberry🫐].shuffled()) } },
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
                id: .fruitsAndVegetablesAdvanced1,
                nextID: .fruitsAndVegetablesAdvanced2,
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
                id: .fruitsAndVegetablesAdvanced2,
                nextID: .fruitsAndVegetablesAdvanced3,
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
                id: .fruitsAndVegetablesAdvanced3,
                nextID: .fruitsAndVegetablesAdvanced4,
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
                id: .fruitsAndVegetablesAdvanced4,
                nextID: .fruitsAndVegetablesAdvanced5,
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
                id: .fruitsAndVegetablesAdvanced5,
                nextID: .fruitsAndVegetablesChallenge,
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
                id: .fruitsAndVegetablesChallenge,
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
