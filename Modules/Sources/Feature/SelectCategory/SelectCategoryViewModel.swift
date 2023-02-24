//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core

@MainActor
public protocol SelectCategoryViewModelProtocol: ObservableObject {
    associatedtype Quiz: VoiceQuiz
    var generators: [VoiceQuizGenerator<Quiz>] { get }
    var gameRecords: [Int: GameRecord] { get }
    var selectedGenerator: VoiceQuizGenerator<Quiz>? { get }
    func selectGenerator(generator: VoiceQuizGenerator<Quiz>?)
    func dismissGame()
    func refresh() async throws
}

#if DEBUG
@MainActor
public final class SelectCategoryViewModelDummy: ObservableObject, SelectCategoryViewModelProtocol {
    public typealias Quiz = VoiceQuizDummy
    
    public var generators: [VoiceQuizGenerator<VoiceQuizDummy>] = VoiceQuizCategoryDummy.allCases.map { $0.generator }
    public var gameRecords: [Int : GameRecord] = [:]
    
    public var selectedGenerator: VoiceQuizGenerator<VoiceQuizDummy>? = nil
    
    public init() {
        gameRecords = generators.reduce(into: [:]) { records, generator in
            records[generator.id] = .init(star1: false, star2: false, star3: false)
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
