//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import SwiftUI

public protocol SoundQuizOption: Identifiable, Hashable, CaseIterable {
    var foregroundColor: Color { get }
    var call: String { get }
    var imageName: String? { get }
}

//public func == (lhs: any SoundQuizOption, rhs: any SoundQuizOption) -> Bool {
//    lhs.hashValue == rhs.hashValue
//}

public extension SoundQuizOption {
    static func randoms(by count: Int) -> [Self] {
        Self.allCases
            .shuffled()
            .prefix(min(count, Self.allCases.count))
            .map { $0 }
    }
}
