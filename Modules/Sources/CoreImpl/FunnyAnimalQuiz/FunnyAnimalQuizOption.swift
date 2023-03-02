//
//  FunnyAnimalQuizOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import SwiftUI
import Extensions
import Core

public enum FunnyAnimalQuizOption: String {
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

extension FunnyAnimalQuizOption: VoiceQuizOption {
    public var id: Self { self }
    
    public var viewType: Core.OptionViewType {
        .text(title: emoji, textColor: .init(uiColor: .label), backgroundColor: .init(uiColor: .systemFill))
    }
    
    public var call: String {
        switch self {
        case .dogFace🐶: return "いぬ"
        case .monkeyFace🐵: return "さる"
        case .lionFace🦁: return "らいおん"
        case .tigerFace🐯: return "とら"
        case .cowFace🐮: return "うし"
        case .pigFace🐷: return "ぶた"
        case .mouseFace🐭: return "ねずみ"
        case .bearFace🐻: return "くま"
        case .pandaFace🐼: return "ぱんだ"
        case .rabbitFace🐰: return "うさぎ"
        case .catFace🐱: return "ねこ"
        case .horseFace🐴: return "うま"
        }
    }
}
 
private extension FunnyAnimalQuizOption {
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
