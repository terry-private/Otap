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
    
    public var generator: VoiceQuizGenerator<Quiz> {
        switch self {
        case .level1:
            return .init(
                id: 0,
                title: "レベル1",
                quizzes: { (0..<10).map { ColorQuiz.random(by: [2, 4, 6, 9, 12][$0 % 5]) } },
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
