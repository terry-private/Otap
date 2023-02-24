//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import Feature

@MainActor
public final class SelectCategoryViewModel<Category: VoiceQuizCategory, UseCase: SelectCategoryUseCase>: ObservableObject, SelectCategoryViewModelProtocol {
    @Published public var generators: [VoiceQuizGenerator<Category.Quiz>] = Category.allCases.map { $0.generator }
    @Published public var gameRecords: [Int: GameRecord] = [:]
    @Published public var selectedGenerator: VoiceQuizGenerator<Category.Quiz>? = nil
    public init() {
        Task {
            try await refresh()
        }
    }
    public func selectGenerator(generator: VoiceQuizGenerator<Category.Quiz>?) {
        selectedGenerator = generator
    }
    public func dismissGame() {
        selectedGenerator = nil
    }
    public func refresh() async throws {
        for generator in generators {
            gameRecords[generator.id] = try await UseCase.fetchGameRecord(id: generator.id)
        }
    }
}
