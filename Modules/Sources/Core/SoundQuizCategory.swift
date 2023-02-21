//
//  SoundQuizLevel.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation

public protocol SoundQuizCategory: CaseIterable {
    associatedtype Quiz: SoundQuiz
    
    var generator: SoundQuizGenerator<Quiz> { get }
}
