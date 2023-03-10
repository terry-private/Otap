//
//  CreatureDrill.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import Core

public struct CreatureDrill: CoreDrill {
    public typealias Option = CreatureDrillOption
    public static let title: String = "生き物"
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
