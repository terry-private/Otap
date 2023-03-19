//
//  CreatureDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import SwiftUI
import Extensions
import Core

public enum CreatureDrillOption: String {
    // animal
    case dog🐕
    case cat🐈
    case rabbit🐇
    case pig🐖
    
    case elephant🐘
    case giraffe🦒
    case chipmunk🐿️
    case cow🐄
    
    case horse🐎
    case monkey🐒
    case mouse🐁
    case tiger🐅
    
    case zebra🦓
    case camel🐪
    case kangaroo🦘
    case rhinoceros🦏
    
    // bird
    case rooster🐓
    case owl🦉
    case flamingo🦩
    case swan🦢
    case duck🦆
    case bat🦇
    
    // reptile
    case turtle🐢
    case crocodile🐊
    case lizard🦎
    case snake🐍
    
    // marine life
    case whale🐋
    case dolphin🐬
    case shark🦈
    case octopus🐙
    
    // insect
    case bug🐛
    case butterfly🦋
    case ant🐜
    case honeybee🐝
    case ladyBeetle🐞
    case spider🕷
}

extension CreatureDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        .text(title: emoji)
    }
    
    public func call(_ language: String) -> String {
        switch self {
        case .dog🐕: return localized("Creature.Option.Call.dog", language) ?? "dog"
        case .cat🐈: return localized("Creature.Option.Call.cat", language) ?? "cat"
        case .mouse🐁: return localized("Creature.Option.Call.mouse", language) ?? "mouse"
        case .cow🐄: return localized("Creature.Option.Call.cow", language) ?? "cow"
        case .rabbit🐇: return localized("Creature.Option.Call.rabbit", language) ?? "rabbit"
        case .horse🐎: return localized("Creature.Option.Call.horse", language) ?? "horse"
        case .elephant🐘: return localized("Creature.Option.Call.elephant", language) ?? "elephant"
        case .pig🐖: return localized("Creature.Option.Call.pig", language) ?? "pig"
        case .camel🐪: return localized("Creature.Option.Call.camel", language) ?? "camel"
        case .giraffe🦒: return localized("Creature.Option.Call.giraffe", language) ?? "giraffe"
        case .kangaroo🦘: return localized("Creature.Option.Call.kangaroo", language) ?? "kangaroo"
        case .monkey🐒: return localized("Creature.Option.Call.monkey", language) ?? "monkey"
        case .rooster🐓: return localized("Creature.Option.Call.rooster", language) ?? "rooster"
        case .owl🦉: return localized("Creature.Option.Call.owl", language) ?? "owl"
        case .flamingo🦩: return localized("Creature.Option.Call.flamingo", language) ?? "flamingo"
        case .swan🦢: return localized("Creature.Option.Call.swan", language) ?? "swan"
        case .duck🦆: return localized("Creature.Option.Call.duck", language) ?? "duck"
        case .bat🦇: return localized("Creature.Option.Call.bat", language) ?? "bat"
        case .turtle🐢: return localized("Creature.Option.Call.turtle", language) ?? "turtle"
        case .crocodile🐊: return localized("Creature.Option.Call.crocodile", language) ?? "crocodile"
        case .lizard🦎: return localized("Creature.Option.Call.lizard", language) ?? "lizard"
        case .snake🐍: return localized("Creature.Option.Call.snake", language) ?? "snake"
        case .whale🐋: return localized("Creature.Option.Call.whale", language) ?? "whale"
        case .dolphin🐬: return localized("Creature.Option.Call.dolphin", language) ?? "dolphin"
        case .shark🦈: return localized("Creature.Option.Call.shark", language) ?? "shark"
        case .octopus🐙: return localized("Creature.Option.Call.octopus", language) ?? "octopus"
        case .bug🐛: return localized("Creature.Option.Call.bug", language) ?? "bug"
        case .butterfly🦋: return localized("Creature.Option.Call.butterfly", language) ?? "butterfly"
        case .ant🐜: return localized("Creature.Option.Call.ant", language) ?? "ant"
        case .honeybee🐝: return localized("Creature.Option.Call.honeybee", language) ?? "honeybee"
        case .ladyBeetle🐞: return localized("Creature.Option.Call.ladyBeetle", language) ?? "lady beetle"
        case .spider🕷: return localized("Creature.Option.Call.spider", language) ?? "spider"
        case .chipmunk🐿️: return localized("Creature.Option.Call.chipmunk", language) ?? "chipmunk"
        case .tiger🐅: return localized("Creature.Option.Call.tiger", language) ?? "tiger"
        case .zebra🦓: return localized("Creature.Option.Call.zebra", language) ?? "zebra"
        case .rhinoceros🦏: return localized("Creature.Option.Call.rhinoceros", language) ?? "rhinoceros"
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 4)
    }
}
 
private extension CreatureDrillOption {
    var emoji: String {
        switch self {
        case .dog🐕: return "🐕"
        case .cat🐈: return "🐈"
        case .mouse🐁: return "🐁"
        case .cow🐄: return "🐄"
        case .rabbit🐇: return "🐇"
        case .horse🐎: return "🐎"
        case .elephant🐘: return "🐘"
        case .pig🐖: return "🐖"
        case .camel🐪: return "🐪"
        case .giraffe🦒: return "🦒"
        case .kangaroo🦘: return "🦘"
        case .monkey🐒: return "🐒"
        case .rooster🐓: return "🐓"
        case .owl🦉: return "🦉"
        case .flamingo🦩: return "🦩"
        case .swan🦢: return "🦢"
        case .duck🦆: return "🦆"
        case .bat🦇: return "🦇"
        case .turtle🐢: return "🐢"
        case .crocodile🐊: return "🐊"
        case .lizard🦎: return "🦎"
        case .snake🐍: return "🐍"
        case .whale🐋: return "🐋"
        case .dolphin🐬: return "🐬"
        case .shark🦈: return "🦈"
        case .octopus🐙: return "🐙"
        case .bug🐛: return "🐛"
        case .butterfly🦋: return "🦋"
        case .ant🐜: return "🐜"
        case .honeybee🐝: return "🐝"
        case .ladyBeetle🐞: return "🐞"
        case .spider🕷: return "🕷"
        case .chipmunk🐿️: return "🐿️"
        case .tiger🐅: return "🐅"
        case .zebra🦓: return "🦓"
        case .rhinoceros🦏: return "🦏"
        }
    }
}
