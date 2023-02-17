//
//  SoundQuiz.swift.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import Foundation

public protocol SoundQuiz<Option>: Hashable {
    associatedtype Option: SoundQuizOption
    static var title: String { get }
    var options: [Option] { get }
    var answer: Option { get }
    init(options: [Option])
    init(options: [Option], answer: Option)
}

public extension SoundQuiz {
    static func random(by count: Int) -> Self {
        .init(options: Option.randoms(by: count))
    }
}
