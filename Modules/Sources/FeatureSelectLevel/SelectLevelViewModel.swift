//
//  SelectLevelViewModel.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core

@MainActor
public protocol SelectLevelViewModelProtocol<Quiz>: ObservableObject {
    associatedtype Quiz: VoiceQuiz
    var generators: [VoiceQuizGenerator<Quiz>] { get }
    var gameRecords: [LevelSelectorID: GameRecord] { get }
    var selectedGenerator: VoiceQuizGenerator<Quiz>? { get }
    var initialRefreshTask: Task<Void, Error>? { get }
    var isPresentingPracticeMode: Bool { get set }
    
    @discardableResult
    func selectGenerator(generator: VoiceQuizGenerator<Quiz>?) -> Task<Void, Never>
    
    @discardableResult
    func dismissGame() -> Task<Void, Never>
    
    func refresh() async throws
    
    func practiceModeTapped()
}

@MainActor
public final class SelectLevelViewModelImpl<LevelSelector: VoiceQuizLevelSelector, UseCase: SelectLevelUseCase>: ObservableObject, SelectLevelViewModelProtocol {
    public let generators: [VoiceQuizGenerator<LevelSelector.Quiz>] = LevelSelector.allCases.map { $0.generator }
    public private(set) var initialRefreshTask: Task<Void, Error>? = nil
    @Published public var gameRecords: [LevelSelectorID: GameRecord] = [:]
    @Published public var selectedGenerator: VoiceQuizGenerator<LevelSelector.Quiz>? = nil
    @Published public var isPresentingPracticeMode: Bool = false
    public init() {
        initialRefreshTask = Task {
            try await refresh()
        }
    }
    
    @discardableResult
    public func selectGenerator(generator: VoiceQuizGenerator<LevelSelector.Quiz>?) -> Task<Void, Never> {
        Task {
            selectedGenerator = generator
        }
    }
    
    @discardableResult
    public func dismissGame() -> Task<Void, Never> {
        return selectGenerator(generator: nil)
    }
    
    public func refresh() async throws {
        for generator in generators {
            gameRecords[generator.id] = try await UseCase.fetchGameRecord(id: generator.id)
        }
    }
    
    public func practiceModeTapped() {
        isPresentingPracticeMode.toggle()
    }
}


#if DEBUG
@MainActor
public final class SelectLevelViewModelDummy: ObservableObject, SelectLevelViewModelProtocol {
    public typealias Quiz = VoiceQuizDummy
    
    public var generators: [VoiceQuizGenerator<VoiceQuizDummy>] = VoiceQuizLevelSelectorDummy.allCases.map { $0.generator }
    public var gameRecords: [LevelSelectorID : GameRecord] = [:]
    public var initialRefreshTask: Task<Void, Error>? = nil
    public var selectedGenerator: VoiceQuizGenerator<VoiceQuizDummy>? = nil
    public var isPresentingPracticeMode: Bool = false
    
    public init() {
        gameRecords = generators.reduce(into: [:]) { records, generator in
            records[generator.id] = .init(id: generator.id)
        }
    }
    
    @discardableResult
    public func selectGenerator(generator: VoiceQuizGenerator<VoiceQuizDummy>?) -> Task<Void, Never> {
        Task {
            selectedGenerator = generator
        }
    }
    
    @discardableResult
    public func dismissGame() -> Task<Void, Never> {
        return selectGenerator(generator: nil)
    }
    
    public func refresh() async throws {
    }
    
    public func practiceModeTapped() {
        isPresentingPracticeMode.toggle()
    }
}
#endif
