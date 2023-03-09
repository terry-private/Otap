//
//  FruitsAndVegetablesQuizOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/03.
//

import SwiftUI
import Extensions
import Core

public enum FruitsAndVegetablesQuizOption: String {
    case tomato🍅
    case eggplant🍆
    case potato🥔
    case carrot🥕
    
    case onion🧅
    case cucumber🥒
    case corn🌽
    case broccoli🥦
    
    case sweetPotato🍠
    case greenBellPepper🫑
    case chestnuts🌰
    case mushrooms🍄
    
    case orange🍊
    case apple🍎
    case grape🍇
    case kiwi🥝
    
    case watermelon🍉
    case lemon🍋
    case peach🍑
    case strawberry🍓
    
    case banana🍌
    case pineapple🍍
    case melon🍈
    case blueberry🫐
    
}

extension FruitsAndVegetablesQuizOption: VoiceQuizOption {
    public var id: Self { self }
    
    public var viewType: Core.OptionViewType {
        .text(title: emoji, textColor: .init(uiColor: .label), backgroundColor: .init(uiColor: .systemFill))
    }
    
    public var call: String {
        switch self {
        case .tomato🍅: return "とまと"
        case .eggplant🍆: return "なす"
        case .potato🥔: return "じゃがいも"
        case .carrot🥕: return "にんじん"
        case .onion🧅: return "たまねぎ"
        case .cucumber🥒: return "きゅうり"
        case .corn🌽: return "とうもろこし"
        case .broccoli🥦: return "ブロッコリー"
        case .sweetPotato🍠: return "さつまいも"
        case .greenBellPepper🫑: return "ぴーまん"
        case .chestnuts🌰: return "くり"
        case .mushrooms🍄: return "きのこ"
        case .orange🍊: return "オレンジ"
        case .apple🍎: return "りんご"
        case .grape🍇: return "ぶどう"
        case .kiwi🥝: return "きうい"
        case .watermelon🍉: return "すいか"
        case .lemon🍋: return "れもん"
        case .peach🍑: return "もも"
        case .strawberry🍓: return "いちご"
        case .banana🍌: return "ばなな"
        case .pineapple🍍: return "ぱいなっぷる"
        case .melon🍈: return "めろん"
        case .blueberry🫐: return "ぶるーべりー"
            
        }
    }
    
    public static var practiceRows: [[Self]] {
        (0..<allCases.count/4).map { rowIndex in
            allCases[rowIndex*4..<rowIndex*4+4].map { $0 }
        }
    }
}

private extension FruitsAndVegetablesQuizOption {
    var emoji: String {
        switch self {
        case .tomato🍅: return "🍅"
        case .eggplant🍆: return "🍆"
        case .potato🥔: return "🥔"
        case .carrot🥕: return "🥕"
        case .onion🧅: return "🧅"
        case .cucumber🥒: return "🥒"
        case .corn🌽: return "🌽"
        case .broccoli🥦: return "🥦"
        case .sweetPotato🍠: return "🍠"
        case .greenBellPepper🫑: return "🫑"
        case .chestnuts🌰: return "🌰"
        case .mushrooms🍄: return "🍄"
        case .orange🍊: return "🍊"
        case .apple🍎: return "🍎"
        case .grape🍇: return "🍇"
        case .kiwi🥝: return "🥝"
        case .watermelon🍉: return "🍉"
        case .lemon🍋: return "🍋"
        case .peach🍑: return "🍑"
        case .strawberry🍓: return "🍓"
        case .banana🍌: return "🍌"
        case .pineapple🍍: return "🍍"
        case .melon🍈: return "🍈"
        case .blueberry🫐: return "🫐"
        }
    }
}
