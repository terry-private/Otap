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
    
    public var call: String {
        switch self {
        case .circle: return L10n.Shape.Option.Call.circle
        case .cross: return L10n.Shape.Option.Call.cross
        case .triangle: return L10n.Shape.Option.Call.triangle
        case .square: return L10n.Shape.Option.Call.square
        case .star: return L10n.Shape.Option.Call.star
        case .heart: return L10n.Shape.Option.Call.heart
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 3)
    }
}
