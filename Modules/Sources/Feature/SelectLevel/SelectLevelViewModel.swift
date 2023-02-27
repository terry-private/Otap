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
    func selectGenerator(generator: VoiceQuizGenerator<Quiz>?)
    func dismissGame()
    func refresh() async throws
}

@MainActor
public final class SelectLevelViewModelImpl<LevelSelector: VoiceQuizLevelSelector, UseCase: SelectLevelUseCase>: ObservableObject, SelectLevelViewModelProtocol {
    public let generators: [VoiceQuizGenerator<LevelSelector.Quiz>] = LevelSelector.allCases.map { $0.generator }
    @Published public var gameRecords: [LevelSelectorID: GameRecord] = [:]
    @Published public var selectedGenerator: VoiceQuizGenerator<LevelSelector.Quiz>? = nil
    public init() {
        Task {
            try await refresh()
        }
    }
    public func selectGenerator(generator: VoiceQuizGenerator<LevelSelector.Quiz>?) {
        Task {
            selectedGenerator = generator
        }
    }
    public func dismissGame() {
        selectGenerator(generator: nil)
    }
    public func refresh() async throws {
        for generator in generators {
            gameRecords[generator.id] = try await UseCase.fetchGameRecord(id: generator.id)
        }
    }
}


#if DEBUG
@MainActor
public final class SelectLevelViewModelDummy: ObservableObject, SelectLevelViewModelProtocol {
    public typealias Quiz = VoiceQuizDummy
    
    public var generators: [VoiceQuizGenerator<VoiceQuizDummy>] = VoiceQuizLevelSelectorDummy.allCases.map { $0.generator }
    public var gameRecords: [LevelSelectorID : GameRecord] = [:]
    
    public var selectedGenerator: VoiceQuizGenerator<VoiceQuizDummy>? = nil
    
    public init() {
        gameRecords = generators.reduce(into: [:]) { records, generator in
            records[generator.id] = .init()
        }
    }
    
    public func selectGenerator(generator: VoiceQuizGenerator<VoiceQuizDummy>?) {
        selectedGenerator = generator
    }
    
    
    public func dismissGame() {
        selectedGenerator = nil
    }
    
    public func refresh() async throws {
    }
}
#endif
