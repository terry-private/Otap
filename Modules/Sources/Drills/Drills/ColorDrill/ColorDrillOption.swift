//
//  ColorDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import SwiftUI
import Extensions
import Core

public enum ColorDrillOption: String {
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

extension ColorDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: Core.OptionViewType {
        .color(foregroundColor)
    }
    
    public var call: String {
        switch self {
        case .red: return L10n.Color.Option.Call.red
        case .pink: return L10n.Color.Option.Call.pink
        case .blue: return L10n.Color.Option.Call.blue
        case .lightBlue: return L10n.Color.Option.Call.lightBlue
        case .green: return L10n.Color.Option.Call.green
        case .yellow: return L10n.Color.Option.Call.yellow
        case .purple: return L10n.Color.Option.Call.purple
        case .orange: return L10n.Color.Option.Call.orange
        case .brown: return L10n.Color.Option.Call.brown
        case .white: return L10n.Color.Option.Call.white
        case .gray: return L10n.Color.Option.Call.gray
        case .black: return L10n.Color.Option.Call.black
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 3)
    }
}
 
private extension ColorDrillOption {
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
