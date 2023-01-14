//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import SwiftUI

public struct ColorGame: TapGame {
    public enum ColorOption: TapOption, CaseIterable {
        case red
        case blue
        case green
        case yellow
        case purple
        case pink
        case orange
        case brown
        
        public var foregroundColor: Color {
            switch self {
            case .red: return .red
            case .blue: return .blue
            case .green: return .green
            case .yellow: return .yellow
            case .purple: return .purple
            case .pink: return .pink
            case .orange: return .orange
            case .brown: return .brown
            }
        }
        
        public var call: String {
            switch self {
            case .red: return "あか"
            case .blue: return "あお"
            case .green: return "みどり"
            case .yellow: return "きいろ"
            case .purple: return "むらさき"
            case .pink: return "ぴんく"
            case .orange: return "おれんじ"
            case .brown: return "ちゃいろ"
            }
        }
        
        public var imageName: String? { nil }
    }
    
    public var options: [ColorOption]
    public var answer: ColorOption
    
    public init(
        options: [ColorOption] = ColorOption.allCases
            .shuffled()
            .prefix(4)
            .map{ $0 }
    ) {
        self.options = options
        answer = options.randomElement()!
    }
}
