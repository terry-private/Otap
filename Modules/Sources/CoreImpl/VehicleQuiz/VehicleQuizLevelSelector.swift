//
//  VehicleQuizLevelSelector.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import Core

public enum VehicleQuizLevelSelector: VoiceQuizLevelSelector {
    public typealias Quiz = VehicleQuiz
    case basic1
    case basic2
    case basic3
    case advanced1
    case advanced2
    case advanced3
    case advanced4
    case challenge
    
    public static var previewQuiz: Quiz {
        .init(options: [.train🚃, .policeCar🚓, .bicycle🚲, .airPlane🛩])
    }
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .basic1:
            return .init(
                id: .vehicleBasic1,
                nextID: .vehicleBasic2,
                title: "基本1",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.highSpeedTrain🚄, .train🚃, .locomotive🚂, .airPlane🛩].shuffled()) } },
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
                id: .vehicleBasic2,
                nextID: .vehicleBasic3,
                title: "基本2",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.bus🚌, .ambulance🚑, .fireEngine🚒, .policeCar🚓].shuffled()) } },
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
                id: .vehicleBasic3,
                nextID: .vehicleAdvanced1,
                title: "基本3",
                requirements: "60秒以内に10問正解",
                quizzes: { (0..<10).map { _ in .init(options: [.taxi🚕, .truck🚛, .bike🏍, .bicycle🚲].shuffled()) } },
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
                id: .vehicleAdvanced1,
                nextID: .vehicleAdvanced2,
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
                id: .vehicleAdvanced2,
                nextID: .vehicleAdvanced3,
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
                id: .vehicleAdvanced3,
                nextID: .vehicleAdvanced4,
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
                id: .vehicleAdvanced4,
                nextID: .vehicleChallenge,
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
        case .challenge:
            return .init(
                id: .vehicleChallenge,
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
