//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/25.
//

import Core

public struct AnimalQuiz: VoiceQuiz {
    public static let title: String = "動物クイズ"
    public var options: [AnimalQuizOption]
    public let answer: AnimalQuizOption
    
    public init(options: [AnimalQuizOption]) {
        self.options = options
        answer = options.randomElement()!
    }
    public init(options: [AnimalQuizOption], answer: AnimalQuizOption) {
        self.options = options
        self.answer = answer
    }
    
}
