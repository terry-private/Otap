//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import Foundation

public protocol AudioQuiz<Choice> {
    associatedtype Choice: AudioQuizChoice
    var choices: [Choice] { get }
    var answer: Choice { get }
    var level: AudioQuizLevel { get }
    init(choices: [Choice])
}

public extension AudioQuiz {
    init(by level: AudioQuizLevel = .random) {
        self = .init(choices: Choice.randoms(by: level))
    }
}

public enum AudioQuizLevel: Int, CaseIterable {
    case level1 = 2
    case level2 = 4
    case level3 = 6
    case level4 = 9
    case level5 = 12
    
    public init(by choiceCount: Int) {
        guard let level = Self.init(rawValue: choiceCount) else {
            switch choiceCount {
            case (0...2):
                self = .level1
            case (3...4):
                self = .level2
            case (5...6):
                self = .level3
            case (7...9):
                self = .level4
            default:
                self = .level5
            }
            return
        }
        self = level
    }
    
    public static var random: Self {
        allCases.randomElement()!
    }
}
