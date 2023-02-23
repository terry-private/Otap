//
//  VoiceQuizLevel.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation

public protocol VoiceQuizCategory: Hashable, Identifiable, CaseIterable {
    associatedtype Quiz: VoiceQuiz
    
    var generator: VoiceQuizGenerator<Quiz> { get }
}

public extension VoiceQuizCategory {
    var id: VoiceQuizGenerator<Quiz>.ID {
        generator.id
    }
}

#if DEBUG
public enum VoiceQuizCategoryDummy: VoiceQuizCategory {
    public typealias Quiz = VoiceQuizDummy
    
    case level1
    case level2
    
    public var generator: VoiceQuizGenerator<VoiceQuizDummy> {
        switch self {
        case .level1:
            return .init(
                id: 0,
                title: "レベル1",
                quizzes: { (0..<10).map { _ in .random(by: 4) } },
                timeLimit: 30,
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
                title: "レベル2",
                quizzes: { (0..<10).map { _ in .random(by: 6) } },
                timeLimit: 30,
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
        }
    }
    
}
#endif
