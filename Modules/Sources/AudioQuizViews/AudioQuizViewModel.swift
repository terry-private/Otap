//
//  AudioQuizViewModel.swift
//  
//
//  Created by 若江照仁 on 2023/01/17.
//

import SwiftUI
import SoundEffectUseCase
import AudioQuiz

@MainActor
public protocol AudioQuizViewModelProtocol: ObservableObject {
    var selectedIndex: Int? { get }
    var currentIndex: Int { get }
    var isEmpty: Bool { get }
    var currentQuizType: AudioQuizType { get }
    var quizzesCount: Int { get }
    
    func onAppear()
    func speakerButtonTapped()
    func choiceTapped(_ index: Int)
    func playSoundEffect()
    func getState(_ index: Int) -> AudioQuizChoiceState
}

@MainActor
public final class AudioQuizViewModel<SEUseCase: SoundEffectUseCaseProtocol>: ObservableObject {
    // ------------------------------------------------
    // MARK: private properties
    // ------------------------------------------------
    private var quizTypes: [AudioQuizType]
    
    private var selectedChoice: (some AudioQuizChoice)? {
        selectedIndex.map{ currentQuizType.quiz.choices[$0] }
    }
    
    // ------------------------------------------------
    // MARK: AudioQuizViewModelProtocol properties
    // ------------------------------------------------
    @Published private(set) public var selectedIndex: Int?
    @Published private(set) public var currentIndex: Int = 0
    @Published private(set) public var isEmpty: Bool = false
    
    public let quizzesCount: Int
    
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(quizzes: [AudioQuizType]) {
        self.quizTypes = quizzes
        quizzesCount = quizzes.count
    }
}

// MARK: - AudioQuizViewModelProtocol methods
extension AudioQuizViewModel: AudioQuizViewModelProtocol {
    public var currentQuizType: AudioQuizType {
        quizTypes[currentIndex]
    }
    
    public func onAppear() {
        speak()
    }
    
    public func speakerButtonTapped() {
        speak()
    }
    
    public func choiceTapped(_ index: Int) {
        guard selectedIndex == nil else {
            return
        }
        selectedIndex = index
        playSoundEffect()
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 500_000_000)
            guard currentIndex < quizTypes.count - 1 else { return }
            selectedIndex = nil
            currentIndex += 1
            speak()
        }
    }
    
    public func playSoundEffect() {
        guard let selectedIndex else {
            return
        }
        let selectedChoice = currentQuizType.quiz.choices[selectedIndex]
        let answer = currentQuizType.quiz.answer

        if answer == selectedChoice {
            SEUseCase.playCorrect()
        } else {
            SEUseCase.playWrong()
        }
    }
    
    public func getState(_ index: Int) -> AudioQuizChoiceState {
        guard let selectedIndex, currentIndex < quizTypes.count else {
            return .unanswered
        }
        let selectedChoice = currentQuizType.quiz.choices[selectedIndex]
        let choice = currentQuizType.quiz.choices[index]
        guard selectedChoice == choice else {
            return .unselected
        }
        if currentQuizType.quiz.answer == choice {
            return .correct
        } else {
            return .wrong
        }
    }
}

// MARK: - private methods
private extension AudioQuizViewModel {
    func speak() {
        guard currentIndex < quizTypes.count else { return }
        SEUseCase.speak(currentQuizType.quiz.answer.call)
    }
}
