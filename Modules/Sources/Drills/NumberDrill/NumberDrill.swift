//
//  NumberDrill.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import Foundation
import Core

public struct NumberDrill: CoreDrill {
    public typealias Option = NumberDrillOption
    public static let title: String = L10n.Number.Drill.title
    public static let specificLanguage: Locale.Language? = nil
    public var options: [Option]
    public let answer: Option
    
    public init(options: [Option]) {
        self.options = options
        answer = options.randomElement()!
    }
    public init(options: [Option], answer: Option) {
        self.options = options
        self.answer = answer
    }
}
