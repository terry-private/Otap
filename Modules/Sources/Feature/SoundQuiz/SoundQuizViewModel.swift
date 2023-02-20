//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation
import Core

public enum GameState<Option: SoundQuizOption>: Equatable {
    case ready
    case playing
    case verifying(Option)
    case gameOver(GameResult)
}

public enum OptionState {
    case unanswered
    case unselected
    case correct
    case wrong
}

@MainActor
public protocol SoundQuizViewModelProtocol<Quiz>: ObservableObject {
    associatedtype Quiz: SoundQuiz
    var gameState: GameState<Quiz.Option> { get }
    var currentQuiz: Quiz { get }
    var isWarning: Bool { get }
    var isLoading: Bool { get }
    var isNewRecord: Bool { get }
    var achievement: Achievement { get }
    var star1Description: String { get }
    var star2Description: String { get }
    var star3Description: String { get }
    var time: Double { get }
    var timeLimit: Double { get }
    var quizProgress: Double { get }
    var ghostProgress: Double { get }
    var currentTimeSecond: String { get }
    var currentTimeDecimal: String { get }
    
    func start()
    func restart()
    func speakerButtonTapped()
    func optionTapped(_ option: Quiz.Option)
    func getState(_ option: Quiz.Option) -> OptionState
}
