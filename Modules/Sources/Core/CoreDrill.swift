//
//  CoreDrill.swift.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import Foundation

public protocol CoreDrill<Option>: Hashable {
    associatedtype Option: DrillOption
    static var title: String { get }
    static var specificLanguage: Locale.Language? { get }
    var options: [Option] { get }
    var answer: Option { get }
    init(options: [Option])
    init(options: [Option], answer: Option)
}

public extension CoreDrill {
    static func random(by count: Int) -> Self {
        .init(options: Option.randoms(by: count))
    }
}

#if DEBUG
import SwiftUI
import Extensions

public struct DrillDummy: CoreDrill {
    public static let specificLanguage: Locale.Language? = nil
    
    public enum DummyOption: String, DrillOption {
        case red, blue, yellow, green, white, black, pink, purple
        
        public var viewType: OptionViewType {
            .color(foregroundColor)
        }
        
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
        
        public var id: Self { self }
        
        public static var practiceRows: [[Self]] {
            (0..<allCases.count/4).map { rowIndex in
                allCases[rowIndex*4..<rowIndex*4+4].map { $0 }
            }
        }
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
