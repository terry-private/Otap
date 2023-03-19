//
//  DrillViewModel.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation
import Core
import Utility
import SwiftUI

public enum DrillState<Option: DrillOption>: Equatable {
    case ready
    case playing
    case verifying(Option)
    case penaltyTime
    case gameOver(DrillResult)
    
    public var isReady: Bool {
        if case .ready = self {
            return true
        } else {
            return false
        }
    }
    
    public var isGameOver: Bool {
        if case .gameOver = self {
            return true
        } else {
            return false
        }
    }
    
    public var shouldStartDrill: Bool {
        switch self {
        case .verifying, .penaltyTime:
            return true
        default:
            return false
        }
    }
}

public enum OptionState {
    case unanswered
    case unselected
    case selected(isCorrect: Bool)
}

@MainActor
public protocol DrillViewModelProtocol<Drill>: ObservableObject {
    associatedtype Drill: CoreDrill
    var drillState: DrillState<Drill.Option> { get }
    var currentDrill: Drill { get }
    var isWarning: Bool { get }
    var isLoading: Bool { get }
    var remainDrillCount: Int { get }
    var wrongCount: Int { get }
    var lastRecord: DrillRecord { get }
    var levelTitle: String { get }
    var requirements: String { get }
    var star1Description: String { get }
    var star2Description: String { get }
    var star3Description: String { get }
    var time: Double { get }
    var remainTime: Double { get }
    var timeLimit: Double { get }
    var drillProgress: Double { get }
    var ghostProgress: Double { get }
    var dismiss: () -> Void { get }
    
    func start()
    func restart()
    func speakerButtonTapped()
    
    @discardableResult
    func optionTapped(_ option: Drill.Option) -> Task<Void, Error>
    func getState(_ option: Drill.Option) -> OptionState
}

@MainActor
public final class DrillViewModelImpl<
    Drill: CoreDrill,
    SoundEffect: SoundEffectUseCase,
    UseCase: DrillUseCase<Drill>
>: ObservableObject {
    // ------------------------------------------------
    // MARK: 🚪📦private properties
    // ------------------------------------------------
    private let useCase: UseCase
    private var currentDrillIndex: Int = 0
    private var timer: Timer?
    
    // ------------------------------------------------
    // MARK: 🌎📦DrillViewModelProtocol properties
    // ------------------------------------------------
    @Published private(set) public var drillState: DrillState<Drill.Option> = .ready
    @Published private(set) public var time: Double = 0
    @Published private(set) public var drillProgress: Double = .zero
    @Published private(set) public var isWarning: Bool = false
    @Published private(set) public var isLoading: Bool = false
    @Published private(set) public var currentDrill: Drill
    public let dismiss: () -> Void
    
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(useCase: UseCase, dismiss: @escaping () -> Void) {
        self.useCase = useCase
        self.dismiss = dismiss
        currentDrill = useCase.nextDrill()
    }
}

// MARK: - DrillViewModelProtocol get only properties
extension DrillViewModelImpl: DrillViewModelProtocol {
    public var levelTitle: String { useCase.levelTitle }
    public var requirements: String { useCase.requirements }
    public var star1Description: String { useCase.star1Description }
    public var star2Description: String { useCase.star2Description }
    public var star3Description: String { useCase.star3Description }
    
    public var remainDrillCount: Int { useCase.drillCount - currentDrillIndex }
    public var wrongCount: Int { useCase.wrongCount }
    
    public var remainTime: Double { useCase.timeLimit - time }
    public var timeLimit: Double { useCase.timeLimit }
    public var lastRecord: DrillRecord { useCase.lastRecord }
    public var ghostProgress: Double {
        guard let lastRecordTime = lastRecord.time else {
            return .zero
        }
        return time / lastRecordTime
    }
}

// MARK: - DrillViewModelProtocol methods
extension DrillViewModelImpl {
    public func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.time += 0.01
                switch self.time {
                case -.infinity..<self.timeLimit - 10:
                    break
                case self.timeLimit-10 ..< self.timeLimit:
                    self.isWarning = true
                default:
                    self.stopTimer()
                    self.drillState = .gameOver(self.useCase.drillResult(time: self.time))
                }
            }
        }
        currentDrill = useCase.nextDrill()
        startDrill()
    }
    
    public func restart() {
        stopTimer()
        time = .zero
        currentDrillIndex = 0
        drillProgress = .zero
        isWarning = false
        drillState = .ready
        Task {
            isLoading = true
            do {
                try await useCase.refresh()
                isLoading = false
            } catch {
                print(error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    public func speakerButtonTapped() {
        speak()
    }
    
    @discardableResult
    public func optionTapped(_ option: Drill.Option) -> Task<Void, Error> {
        guard case .playing = drillState else {
            return Task {}
        }
        drillState = .verifying(option)
        let isCorrect = option == currentDrill.answer
        playSoundEffect(isCorrect)
        if isCorrect {
            currentDrillIndex += 1
            withAnimation(.easeInOut(duration: useCase.verifyDuration)) {
                drillProgress = Double(currentDrillIndex) / Double(useCase.drillCount)
            }
        }
        
        if currentDrillIndex == useCase.drillCount || (!isCorrect && useCase.penalty == .gameOver) {
            stopTimer()
        }
        return Task {
            try? await Task.sleep(seconds: useCase.verifyDuration)
            // タイムオーバーになっている場合を考慮している
            guard drillState.shouldStartDrill else {
                return
            }
            
            useCase.recordDrillResult(isCorrect: isCorrect)
            guard currentDrillIndex < useCase.drillCount else {
                drillState = .gameOver(useCase.drillResult(time: time))
                return
            }
            if isCorrect {
                currentDrill = useCase.nextDrill()
            } else {
                switch useCase.penalty {
                case .gameOver:
                    drillState = .gameOver(useCase.drillResult(time: time))
                    return
                case .shuffle:
                    drillState = .penaltyTime
                    try await shuffle(4)
                }
            }
            
            // シャッフルアニメーション中にタイムオーバーになっている場合を考慮している
            guard drillState.shouldStartDrill else {
                return
            }
            startDrill()
        }
    }
    
    public func getState(_ option: Drill.Option) -> OptionState {
        guard case .verifying(let selectedOption) = drillState else {
            return .unanswered
        }
        guard selectedOption == option else {
            return .unselected
        }
        return .selected(isCorrect: currentDrill.answer == option)
    }
}

// MARK: - 🚪🧮private methods
private extension DrillViewModelImpl {
    func startDrill() {
        drillState = .playing
        speak()
    }
    
    func option(from id: Drill.Option.ID) -> Drill.Option {
        currentDrill.options.first { $0.id == id }! // force unwrap!
    }
    
    func speak() {
        SoundEffect.speak(currentDrill.answer.call("ja"), Drill.specificLanguage?.minimalIdentifier)
    }
    
    func playSoundEffect(_ isCorrect: Bool) {
        if isCorrect {
            SoundEffect.playCorrect()
        } else {
            SoundEffect.playWrong()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func shuffle(_ count: Int = 1) async throws {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            currentDrill = .init(options: currentDrill.options.shuffled(), answer: currentDrill.answer)
        }
        if count > 0 {
            try? await Task.sleep(seconds: 0.05)
            try await shuffle(count - 1)
        }
    }
}
