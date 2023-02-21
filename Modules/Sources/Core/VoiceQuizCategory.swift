//
//  VoiceQuizLevel.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation

public protocol VoiceQuizCategory: CaseIterable {
    associatedtype Quiz: VoiceQuiz
    
    var generator: VoiceQuizGenerator<Quiz> { get }
}
