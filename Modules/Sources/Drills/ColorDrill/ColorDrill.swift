//
//  ColorDrill.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import Core

public struct ColorDrill: CoreDrill {
    public typealias Option = ColorDrillOption
    public static let title: String = "色"
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
