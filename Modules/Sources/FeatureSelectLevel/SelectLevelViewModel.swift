//
//  SelectLevelViewModel.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core

@MainActor
public protocol SelectLevelViewModelProtocol<Drill>: ObservableObject {
    associatedtype Drill: CoreDrill
    var generators: [DrillGenerator<Drill>] { get }
    var drillRecords: [LevelSelectorID: DrillRecord] { get }
    var selectedGenerator: DrillGenerator<Drill>? { get }
    var initialRefreshTask: Task<Void, Error>? { get }
    var isPresentingPracticeMode: Bool { get set }
    
    @discardableResult
    func selectGenerator(generator: DrillGenerator<Drill>?) -> Task<Void, Never>
    
    @discardableResult
    func dismissDrill() -> Task<Void, Never>
    
    func refresh() async throws
    
    func practiceModeTapped()
}

@MainActor
public final class SelectLevelViewModelImpl<LevelSelector: DrillLevelSelector, UseCase: SelectLevelUseCase>: ObservableObject, SelectLevelViewModelProtocol {
    public let generators: [DrillGenerator<LevelSelector.Drill>] = LevelSelector.allCases.map { $0.generator }
    public private(set) var initialRefreshTask: Task<Void, Error>? = nil
    @Published public var drillRecords: [LevelSelectorID: DrillRecord] = [:]
    @Published public var selectedGenerator: DrillGenerator<LevelSelector.Drill>? = nil
    @Published public var isPresentingPracticeMode: Bool = false
    public init() {
        initialRefreshTask = Task {
            try await refresh()
        }
    }
    
    @discardableResult
    public func selectGenerator(generator: DrillGenerator<LevelSelector.Drill>?) -> Task<Void, Never> {
        Task {
            selectedGenerator = generator
        }
    }
    
    @discardableResult
    public func dismissDrill() -> Task<Void, Never> {
        return selectGenerator(generator: nil)
    }
    
    public func refresh() async throws {
        for generator in generators {
            drillRecords[generator.id] = try await UseCase.fetchDrillRecord(id: generator.id)
        }
    }
    
    public func practiceModeTapped() {
        isPresentingPracticeMode.toggle()
    }
}


#if DEBUG
@MainActor
public final class SelectLevelViewModelDummy: ObservableObject, SelectLevelViewModelProtocol {
    public typealias Drill = DrillDummy
    
    public var generators: [DrillGenerator<DrillDummy>] = DrillLevelSelectorDummy.allCases.map { $0.generator }
    public var drillRecords: [LevelSelectorID : DrillRecord] = [:]
    public var initialRefreshTask: Task<Void, Error>? = nil
    public var selectedGenerator: DrillGenerator<DrillDummy>? = nil
    public var isPresentingPracticeMode: Bool = false
    
    public init() {
        drillRecords = generators.reduce(into: [:]) { records, generator in
            records[generator.id] = .init(id: generator.id)
        }
    }
    
    @discardableResult
    public func selectGenerator(generator: DrillGenerator<DrillDummy>?) -> Task<Void, Never> {
        Task {
            selectedGenerator = generator
        }
    }
    
    @discardableResult
    public func dismissDrill() -> Task<Void, Never> {
        return selectGenerator(generator: nil)
    }
    
    public func refresh() async throws {
    }
    
    public func practiceModeTapped() {
        isPresentingPracticeMode.toggle()
    }
}
#endif
