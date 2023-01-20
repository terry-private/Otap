//
//  AudioQuizType.swift
//  
//
//  Created by 若江照仁 on 2023/01/17.
//

import Foundation

public enum AudioQuizType {
    case colorQuiz(ColorQuiz)
    
    public var quiz: some AudioQuiz {
        switch self {
        case .colorQuiz(let quiz):
            return quiz
        }
    }
    
    public func random(by level: AudioQuizLevel) -> some AudioQuiz {
        switch self {
        case .colorQuiz:
            return ColorQuiz(by: level)
        }
    }
}
