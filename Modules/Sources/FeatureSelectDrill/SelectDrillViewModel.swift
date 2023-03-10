//
//  SelectDrillViewModel.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Foundation
import Core

public protocol SelectDrillViewModelProtocol: ObservableObject {
    var selectors: [any DrillLevelSelector] { get }
    var presentedSelectors: [AnyHashable: Bool] { get }
    func togglePresenting(_ selector: some DrillLevelSelector, isPresenting: Bool)
}

public final class SelectDrillViewModelImpl: ObservableObject, SelectDrillViewModelProtocol {
    public let selectors: [any DrillLevelSelector]
    @Published public private(set) var presentedSelectors: [AnyHashable: Bool]
    public init(selectors: [any DrillLevelSelector]) {
        self.selectors = selectors
        presentedSelectors = selectors.reduce(into: [:]) { presentingSelectors, selector in
            presentingSelectors[selector.id] = false
        }
    }
    public func togglePresenting(_ selector: some DrillLevelSelector, isPresenting: Bool) {
        presentedSelectors[selector.id] = isPresenting
    }
}
