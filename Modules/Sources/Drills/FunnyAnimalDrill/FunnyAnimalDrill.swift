//
//  FunnyAnimalDrill.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import Core

public struct FunnyAnimalDrill: CoreDrill {
    public typealias Option = FunnyAnimalDrillOption
    public static let title: String = L10n.FunnyAnimal.Drill.title
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
