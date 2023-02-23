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
        case red, blue, yellow, green, white, black, pink, purple
        public var foregroundColor: Color {
            switch self {
            case .red: return .red
            case .blue: return .blue
            case .green: return .green
            case .yellow: return .yellow
            case .white: return .white
            case .black: return .black
            case .pink: return .pink
            case .purple: return .purple
            }
        }
        public var call: String {
            switch self {
            case .red: return "あか"
            case .blue: return "あお"
            case .green: return "みどり"
            case .yellow: return "きいろ"
            case .white: return "しろ"
            case .black: return "くろ"
            case .pink: return "ぴんく"
            case .purple: return "むらさき"
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
