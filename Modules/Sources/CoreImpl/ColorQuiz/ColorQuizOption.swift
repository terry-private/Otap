//
//  ColorQuizOption.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import SwiftUI
import Extensions
import Core

public enum ColorQuizOption: String {
    case red
    case pink
    case blue
    case lightBlue
    case green
    case yellow
    case purple
    case orange
    case brown
    case white
    case gray
    case black
}

extension ColorQuizOption: VoiceQuizOption {
    public var id: Self { self }
    
    public var viewType: Core.OptionViewType {
        .color(foregroundColor)
    }
    
    public var call: String {
        switch self {
        case .red: return "あか"
        case .pink: return "ぴんく"
        case .blue: return "あお"
        case .lightBlue: return "みずいろ"
        case .green: return "みどり"
        case .yellow: return "きいろ"
        case .purple: return "むらさき"
        case .orange: return "おれんじ"
        case .brown: return "ちゃいろ"
        case .white: return "しろ"
        case .gray: return "はいいろ"
        case .black: return "くろ"
        }
    }
}
 
private extension ColorQuizOption {
    var foregroundColor: Color {
        switch self {
        case .red: return .init(red: 1, green: 0, blue: 0)
        case .pink: return .init(hex: "FF7FBF")
        case .blue: return .init(red: 0, green: 0, blue: 1)
        case .lightBlue: return .init(red: 0, green: 1, blue: 1)
        case .green: return .init(red: 0, green: 0.5, blue: 0)
        case .yellow: return .init(red: 1, green: 1, blue: 0)
        case .purple: return .init(red: 0.5, green: 0, blue: 0.5)
        case .orange: return .init(hex: "FF8020")
        case .brown: return .init(hex: "8B4513")
        case .white: return .init(hex: "FFFFFF")
        case .gray: return .init(red: 0.5, green: 0.5, blue: 0.5)
        case .black: return .init(red: 0, green: 0, blue: 0)
        }
    }
    
}
