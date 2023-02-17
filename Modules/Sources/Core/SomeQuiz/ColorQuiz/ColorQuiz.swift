//
//  ColorQuiz.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

public struct ColorQuiz: SoundQuiz {
    public static let title: String = "カラーゲーム"
    public var options: [ColorQuizOption]
    public let answer: ColorQuizOption
    
    public init(options: [ColorQuizOption]) {
        self.options = options
        answer = options.randomElement()!
    }
    public init(options: [ColorQuizOption], answer: ColorQuizOption) {
        self.options = options
        self.answer = answer
    }
}
