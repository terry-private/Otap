//
//  ShapeQuizOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import Core

public enum ShapeQuizOption: String {
    case circle
    case cross
    case triangle
    case square
    case heart
    case star
}

extension ShapeQuizOption: VoiceQuizOption {
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
        case .circle: return "まる"
        case .cross: return "ばつ"
        case .triangle: return "さんかく"
        case .square: return "しかく"
        case .star: return "ほし"
        case .heart: return "heart"
        }
    }
}
