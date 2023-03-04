//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Core

public struct ShapeQuiz: VoiceQuiz {
    public typealias Option = ShapeQuizOption
    
    public static let title: String = "形"
    public var options: [Option]
    public let answer: Option
    
    public init(options: [Option]) {
        self.options = options
        answer = options.randomElement()!
    }
    public init(options: [Option], answer: Option) {
        self.options = options
        self.answer = answer
    }
}

