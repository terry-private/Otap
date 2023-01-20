//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import SwiftUI

public protocol AudioQuizChoice: Hashable, CaseIterable {
    var foregroundColor: Color { get }
    var call: String { get }
    var imageName: String? { get }
}

public func == (lhs: any AudioQuizChoice, rhs: any AudioQuizChoice) -> Bool {
    lhs.hashValue == rhs.hashValue
}

public extension AudioQuizChoice {
    static func randoms(by level: AudioQuizLevel) -> [Self] {
        Self.allCases
            .shuffled()
            .prefix(level.rawValue)
            .map { $0 }
    }
}

public enum AudioQuizChoiceState {
    case unanswered
    case unselected
    case correct
    case wrong
}
