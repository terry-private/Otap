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
    
    public func call(_ language: String) -> String {
        switch self {
        case .red: return localized("Color.Option.Call.Red", language) ?? "red"
        case .pink: return localized("Color.Option.Call.Pink", language) ?? "pink"
        case .blue: return localized("Color.Option.Call.Blue", language) ?? "blue"
        case .lightBlue: return localized("Color.Option.Call.LightBlue", language) ?? "light blue"
        case .green: return localized("Color.Option.Call.Green", language) ?? "green"
        case .yellow: return localized("Color.Option.Call.Yellow", language) ?? "yellow"
        case .purple: return localized("Color.Option.Call.Purple", language) ?? "purple"
        case .orange: return localized("Color.Option.Call.Orange", language) ?? "orange"
        case .brown: return localized("Color.Option.Call.Brown", language) ?? "brown"
        case .white: return localized("Color.Option.Call.White", language) ?? "white"
        case .gray: return localized("Color.Option.Call.Gray", language) ?? "gray"
        case .black: return localized("Color.Option.Call.Black", language) ?? "black"
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
