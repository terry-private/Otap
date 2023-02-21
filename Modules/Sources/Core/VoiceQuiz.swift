//
//  VoiceQuiz.swift.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import Foundation

public protocol VoiceQuiz<Option>: Hashable {
    associatedtype Option: VoiceQuizOption
    static var title: String { get }
    var options: [Option] { get }
    var answer: Option { get }
    init(options: [Option])
    init(options: [Option], answer: Option)
}

public extension VoiceQuiz {
    static func random(by count: Int) -> Self {
        .init(options: Option.randoms(by: count))
    }
}

#if DEBUG
import SwiftUI
public struct VoiceQuizDummy: VoiceQuiz {
    public enum DummyOption: String, VoiceQuizOption {
        case red, blue, yellow, green
        public var foregroundColor: Color {
            switch self {
            case .red: return .init(red: 1, green: 0, blue: 0)
            case .blue: return .init(red: 0, green: 0, blue: 1)
            case .green: return .init(red: 0, green: 0.5, blue: 0)
            case .yellow: return .init(red: 1, green: 1, blue: 0)
            }
        }
        public var call: String {
            switch self {
            case .red: return "あか"
            case .blue: return "あお"
            case .green: return "みどり"
            case .yellow: return "きいろ"
            }
        }
        public var imageName: String? { nil }
        
        public var id: Self { self }
    }
    public static let title: String = "ダミーゲーム"
    public var options: [DummyOption]
    public let answer: DummyOption
    
    public init(options: [DummyOption]) {
        self.options = options
        answer = options.randomElement()!
    }
    public init(options: [DummyOption], answer: DummyOption) {
        self.options = options
        self.answer = answer
    }
}
#endif
