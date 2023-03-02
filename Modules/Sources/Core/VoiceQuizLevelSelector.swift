//
//  VoiceQuizLevel.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation

public protocol VoiceQuizLevelSelector: Hashable, Identifiable, CaseIterable {
    associatedtype Quiz: VoiceQuiz
    
    var generator: VoiceQuizGenerator<Quiz> { get }
    static var previewQuiz: Quiz { get }
}

public extension VoiceQuizLevelSelector {
    var id: VoiceQuizGenerator<Quiz>.ID {
        generator.id
    }
}

#if DEBUG
public enum VoiceQuizLevelSelectorDummy: VoiceQuizLevelSelector {
    public typealias Quiz = VoiceQuizDummy
    
    case level1
    case level2
    
    public static var previewQuiz: VoiceQuizDummy {
        VoiceQuizLevelSelectorDummy.level1.generator.previewQuiz
    }
    
    public var generator: VoiceQuizGenerator<VoiceQuizDummy> {
        switch self {
        case .level1:
            return .init(
                id: .colorBasic1,
                nextID: .colorBasic2,
                title: "レベル1",
                requirements: "30秒以内に10問正解",
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
                id: .colorBasic2,
                nextID: nil,
                title: "レベル2",
                requirements: "30秒以内に10問正解",
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
