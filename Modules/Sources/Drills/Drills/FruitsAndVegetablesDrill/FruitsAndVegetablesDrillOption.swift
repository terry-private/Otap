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
    
    public func call(_ language: String) -> String {
        switch self {
        case .tomato🍅: return localized("FruitsAndVegetables.Option.Call.tomato", language) ?? "tomato"
        case .eggplant🍆: return localized("FruitsAndVegetables.Option.Call.eggplant", language) ?? "eggplant"
        case .potato🥔: return localized("FruitsAndVegetables.Option.Call.potato", language) ?? "potato"
        case .carrot🥕: return localized("FruitsAndVegetables.Option.Call.carrot", language) ?? "carrot"
        case .onion🧅: return localized("FruitsAndVegetables.Option.Call.onion", language) ?? "onion"
        case .cucumber🥒: return localized("FruitsAndVegetables.Option.Call.cucumber", language) ?? "cucumber"
        case .corn🌽: return localized("FruitsAndVegetables.Option.Call.corn", language) ?? "corn"
        case .broccoli🥦: return localized("FruitsAndVegetables.Option.Call.broccoli", language) ?? "broccoli"
        case .sweetPotato🍠: return localized("FruitsAndVegetables.Option.Call.sweetPotato", language) ?? "sweet potato"
        case .greenBellPepper🫑: return localized("FruitsAndVegetables.Option.Call.greenBellPepper", language) ?? "green bell pepper"
        case .chestnuts🌰: return localized("FruitsAndVegetables.Option.Call.chestnuts", language) ?? "chestnuts"
        case .mushrooms🍄: return localized("FruitsAndVegetables.Option.Call.mushrooms", language) ?? "mushrooms"
        case .orange🍊: return localized("FruitsAndVegetables.Option.Call.orange", language) ?? "orange"
        case .apple🍎: return localized("FruitsAndVegetables.Option.Call.apple", language) ?? "apple"
        case .grape🍇: return localized("FruitsAndVegetables.Option.Call.grape", language) ?? "grape"
        case .kiwi🥝: return localized("FruitsAndVegetables.Option.Call.kiwi", language) ?? "kiwi"
        case .watermelon🍉: return localized("FruitsAndVegetables.Option.Call.watermelon", language) ?? "watermelon"
        case .lemon🍋: return localized("FruitsAndVegetables.Option.Call.lemon", language) ?? "lemon"
        case .peach🍑: return localized("FruitsAndVegetables.Option.Call.peach", language) ?? "peach"
        case .strawberry🍓: return localized("FruitsAndVegetables.Option.Call.strawberry", language) ?? "strawberry"
        case .banana🍌: return localized("FruitsAndVegetables.Option.Call.banana", language) ?? "banana"
        case .pineapple🍍: return localized("FruitsAndVegetables.Option.Call.pineapple", language) ?? "pineapple"
        case .melon🍈: return localized("FruitsAndVegetables.Option.Call.melon", language) ?? "melon"
        case .blueberry🫐: return localized("FruitsAndVegetables.Option.Call.blueberry", language) ?? "blueberry"
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
