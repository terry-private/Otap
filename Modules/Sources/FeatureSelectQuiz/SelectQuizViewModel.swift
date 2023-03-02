//
//  SelectQuizViewModel.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Foundation
import Core

public protocol SelectQuizViewModelProtocol: ObservableObject {
    var selectors: [any VoiceQuizLevelSelector] { get }
    var presentedSelectors: [AnyHashable: Bool] { get }
    func togglePresenting(_ selector: some VoiceQuizLevelSelector, isPresenting: Bool)
}

public final class SelectQuizViewModelImpl: ObservableObject, SelectQuizViewModelProtocol {
    public let selectors: [any VoiceQuizLevelSelector]
    @Published public private(set) var presentedSelectors: [AnyHashable: Bool]
    public init(selectors: [any VoiceQuizLevelSelector]) {
        self.selectors = selectors
        presentedSelectors = selectors.reduce(into: [:]) { presentingSelectors, selector in
            presentingSelectors[selector.id] = false
        }
    }
    public func togglePresenting(_ selector: some VoiceQuizLevelSelector, isPresenting: Bool) {
        presentedSelectors[selector.id] = isPresenting
    }
}
