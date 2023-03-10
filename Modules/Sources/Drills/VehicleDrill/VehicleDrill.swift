//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/04.
//

import Core

public struct VehicleDrill: CoreDrill {
    public typealias Option = VehicleDrillOption
    
    public static let title: String = "乗り物"
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
