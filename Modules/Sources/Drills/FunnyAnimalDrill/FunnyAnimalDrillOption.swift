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
    
    public var call: String {
        switch self {
        case .dogFace🐶: return L10n.FunnyAnimal.Option.Call.dog
        case .monkeyFace🐵: return L10n.FunnyAnimal.Option.Call.monkey
        case .lionFace🦁: return L10n.FunnyAnimal.Option.Call.lion
        case .tigerFace🐯: return L10n.FunnyAnimal.Option.Call.tiger
        case .cowFace🐮: return L10n.FunnyAnimal.Option.Call.cow
        case .pigFace🐷: return L10n.FunnyAnimal.Option.Call.pig
        case .mouseFace🐭: return L10n.FunnyAnimal.Option.Call.mouse
        case .bearFace🐻: return L10n.FunnyAnimal.Option.Call.bear
        case .pandaFace🐼: return L10n.FunnyAnimal.Option.Call.panda
        case .rabbitFace🐰: return L10n.FunnyAnimal.Option.Call.rabbit
        case .catFace🐱: return L10n.FunnyAnimal.Option.Call.cat
        case .horseFace🐴: return L10n.FunnyAnimal.Option.Call.horse
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
