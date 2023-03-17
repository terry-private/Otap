//
//  FruitsAndVegetablesDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/03.
//

import SwiftUI
import Extensions
import Core

public enum FruitsAndVegetablesDrillOption: String {
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

extension FruitsAndVegetablesDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: Core.OptionViewType {
        .text(title: emoji, textColor: .init(uiColor: .label), backgroundColor: .init(uiColor: .systemFill))
    }
    
    public var call: String {
        switch self {
        case .tomato🍅: return L10n.FruitsAndVegetables.Option.Call.tomato
        case .eggplant🍆: return L10n.FruitsAndVegetables.Option.Call.eggplant
        case .potato🥔: return L10n.FruitsAndVegetables.Option.Call.potato
        case .carrot🥕: return L10n.FruitsAndVegetables.Option.Call.carrot
        case .onion🧅: return L10n.FruitsAndVegetables.Option.Call.onion
        case .cucumber🥒: return L10n.FruitsAndVegetables.Option.Call.cucumber
        case .corn🌽: return L10n.FruitsAndVegetables.Option.Call.corn
        case .broccoli🥦: return L10n.FruitsAndVegetables.Option.Call.broccoli
        case .sweetPotato🍠: return L10n.FruitsAndVegetables.Option.Call.sweetPotato
        case .greenBellPepper🫑: return L10n.FruitsAndVegetables.Option.Call.greenBellPepper
        case .chestnuts🌰: return L10n.FruitsAndVegetables.Option.Call.chestnuts
        case .mushrooms🍄: return L10n.FruitsAndVegetables.Option.Call.mushrooms
        case .orange🍊: return L10n.FruitsAndVegetables.Option.Call.orange
        case .apple🍎: return L10n.FruitsAndVegetables.Option.Call.apple
        case .grape🍇: return L10n.FruitsAndVegetables.Option.Call.grape
        case .kiwi🥝: return L10n.FruitsAndVegetables.Option.Call.kiwi
        case .watermelon🍉: return L10n.FruitsAndVegetables.Option.Call.watermelon
        case .lemon🍋: return L10n.FruitsAndVegetables.Option.Call.lemon
        case .peach🍑: return L10n.FruitsAndVegetables.Option.Call.peach
        case .strawberry🍓: return L10n.FruitsAndVegetables.Option.Call.strawberry
        case .banana🍌: return L10n.FruitsAndVegetables.Option.Call.banana
        case .pineapple🍍: return L10n.FruitsAndVegetables.Option.Call.pineapple
        case .melon🍈: return L10n.FruitsAndVegetables.Option.Call.melon
        case .blueberry🫐: return L10n.FruitsAndVegetables.Option.Call.blueberry
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 4)
    }
}

private extension FruitsAndVegetablesDrillOption {
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
