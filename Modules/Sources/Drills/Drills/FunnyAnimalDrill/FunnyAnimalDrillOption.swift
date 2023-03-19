//
//  FunnyAnimalDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import SwiftUI
import Extensions
import Core

public enum FunnyAnimalDrillOption: String {
    // funny
    case dogFace🐶
    case catFace🐱
    case pigFace🐷
    case rabbitFace🐰
    
    case lionFace🦁
    case cowFace🐮
    case mouseFace🐭
    case horseFace🐴
    
    case monkeyFace🐵
    case tigerFace🐯
    case bearFace🐻
    case pandaFace🐼
}

extension FunnyAnimalDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: Core.OptionViewType {
        .text(title: emoji, textColor: .init(uiColor: .label), backgroundColor: .init(uiColor: .systemFill))
    }
    
    public func call(_ language: String) -> String {
        switch self {
        case .dogFace🐶: return localized("FunnyAnimal.Option.Call.dog", language) ?? "dog"
        case .monkeyFace🐵: return localized("FunnyAnimal.Option.Call.monkey", language) ?? "monkey"
        case .lionFace🦁: return localized("FunnyAnimal.Option.Call.lion", language) ?? "lion"
        case .tigerFace🐯: return localized("FunnyAnimal.Option.Call.tiger", language) ?? "tiger"
        case .cowFace🐮: return localized("FunnyAnimal.Option.Call.cow", language) ?? "cow"
        case .pigFace🐷: return localized("FunnyAnimal.Option.Call.pig", language) ?? "pig"
        case .mouseFace🐭: return localized("FunnyAnimal.Option.Call.mouse", language) ?? "mouse"
        case .bearFace🐻: return localized("FunnyAnimal.Option.Call.bear", language) ?? "bear"
        case .pandaFace🐼: return localized("FunnyAnimal.Option.Call.panda", language) ?? "panda"
        case .rabbitFace🐰: return localized("FunnyAnimal.Option.Call.rabbit", language) ?? "rabbit"
        case .catFace🐱: return localized("FunnyAnimal.Option.Call.cat", language) ?? "cat"
        case .horseFace🐴: return localized("FunnyAnimal.Option.Call.horse", language) ?? "horse"
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 3)
    }
}
 
private extension FunnyAnimalDrillOption {
    var emoji: String {
        switch self {
        case .dogFace🐶: return "🐶"
        case .monkeyFace🐵: return "🐵"
        case .lionFace🦁: return "🦁"
        case .tigerFace🐯: return "🐯"
        case .cowFace🐮: return "🐮"
        case .pigFace🐷: return "🐷"
        case .mouseFace🐭: return "🐭"
        case .bearFace🐻: return "🐻"
        case .pandaFace🐼: return "🐼"
        case .rabbitFace🐰: return "🐰"
        case .catFace🐱: return "🐱"
        case .horseFace🐴: return "🐴"
        }
    }
}
