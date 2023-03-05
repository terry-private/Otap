//
//  NumberQuiz.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import Core

public struct NumberQuiz: VoiceQuiz {
    public typealias Option = NumberQuizOption
    public static let title: String = "数字"
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
