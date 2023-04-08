//
//  ShapeDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Core

public enum ShapeDrillOption: String {
    case circle
    case cross
    case triangle
    case square
    case heart
    case star
}

extension ShapeDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        switch self {
        case .circle: return .systemIcon(systemName: "circle.fill")
        case .cross: return .systemIcon(systemName: "xmark")
        case .triangle: return .systemIcon(systemName: "triangle.fill")
        case .square: return .systemIcon(systemName: "square.fill")
        case .heart: return .systemIcon(systemName: "heart.fill")
        case .star: return .systemIcon(systemName: "star.fill")
        }
    }
    
    public func call(_ language: String) -> String {
        switch self {
        case .circle: return localized("Shape.Option.Call.circle", language) ?? "circle"
        case .cross: return localized("Shape.Option.Call.cross", language) ?? "cross"
        case .triangle: return localized("Shape.Option.Call.triangle", language) ?? "triangle"
        case .square: return localized("Shape.Option.Call.square", language) ?? "square"
        case .star: return localized("Shape.Option.Call.star", language) ?? "star"
        case .heart: return localized("Shape.Option.Call.heart", language) ?? "heart"
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 3)
    }
}
