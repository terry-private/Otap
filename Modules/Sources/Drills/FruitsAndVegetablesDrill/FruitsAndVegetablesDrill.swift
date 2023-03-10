//
//  FruitsAndVegetablesDrill.swift
//  
//
//  Created by 若江照仁 on 2023/03/03.
//

import Core

public struct FruitsAndVegetablesDrill: CoreDrill {
    public typealias Option = FruitsAndVegetablesDrillOption
    public static let title: String = "野菜と果物"
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
