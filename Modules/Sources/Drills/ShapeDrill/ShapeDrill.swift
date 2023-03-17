//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Core

public struct ShapeDrill: CoreDrill {
    public typealias Option = ShapeDrillOption
    
    public static let title: String = L10n.Shape.Drill.title
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

