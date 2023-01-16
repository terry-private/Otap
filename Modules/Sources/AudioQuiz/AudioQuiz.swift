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
}
