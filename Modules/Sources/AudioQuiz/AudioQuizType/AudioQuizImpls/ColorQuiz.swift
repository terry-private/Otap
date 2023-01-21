//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import SwiftUI

public struct ColorQuiz: AudioQuiz {
    public enum ChoiceColor: AudioQuizChoice {
        case red
        case pink
        case blue
        case lightBlue
        case green
        case yellow
        case purple
        case orange
        case brown
        case white
        case gray
        case black
        
        public var foregroundColor: Color {
            switch self {
            case .red: return .init(red: 1, green: 0, blue: 0)
            case .pink: return .init(red: 1, green: 0.5, blue: 0.75)
            case .blue: return .init(red: 0, green: 0, blue: 1)
            case .lightBlue: return .init(red: 0, green: 1, blue: 1)
            case .green: return .init(red: 0, green: 1, blue: 0)
            case .yellow: return .init(red: 1, green: 1, blue: 0)
            case .purple: return .init(red: 0.5, green: 0, blue: 0.5)
            case .orange: return .init(red: 1, green: 165/255, blue: 0)
            case .brown: return .init(red: 139/255, green: 69/255, blue: 19/255)
            case .white: return .init(red: 1, green: 1, blue: 1)
            case .gray: return .init(red: 0.5, green: 0.5, blue: 0.5)
            case .black: return .init(red: 0, green: 0, blue: 0)
            }
        }
        
        public var call: String {
            switch self {
            case .red: return "あか"
            case .pink: return "ぴんく"
            case .blue: return "あお"
            case .lightBlue: return "みずいろ"
            case .green: return "みどり"
            case .yellow: return "きいろ"
            case .purple: return "むらさき"
            case .orange: return "おれんじ"
            case .brown: return "ちゃいろ"
            case .white: return "しろ"
            case .gray: return "はいいろ"
            case .black: return "くろ"
            }
        }
        public var imageName: String? { nil }
    }
    
    public let choices: [ChoiceColor]
    public let answer: ChoiceColor
    public let level: AudioQuizLevel
    
    public init(choices: [ChoiceColor]) {
        self.level = .init(by: choices.count)
        self.choices = choices
        answer = choices.randomElement()!
    }
}
