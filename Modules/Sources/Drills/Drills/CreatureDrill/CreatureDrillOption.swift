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
    
    public var call: String {
        switch self {
        case .dog🐕: return L10n.Creature.Option.Call.dog
        case .cat🐈: return L10n.Creature.Option.Call.cat
        case .mouse🐁: return L10n.Creature.Option.Call.mouse
        case .cow🐄: return L10n.Creature.Option.Call.cow
        case .rabbit🐇: return L10n.Creature.Option.Call.rabbit
        case .horse🐎: return L10n.Creature.Option.Call.horse
        case .elephant🐘: return L10n.Creature.Option.Call.elephant
        case .pig🐖: return L10n.Creature.Option.Call.pig
        case .camel🐪: return L10n.Creature.Option.Call.camel
        case .giraffe🦒: return L10n.Creature.Option.Call.giraffe
        case .kangaroo🦘: return L10n.Creature.Option.Call.kangaroo
        case .monkey🐒: return L10n.Creature.Option.Call.monkey
        case .rooster🐓: return L10n.Creature.Option.Call.rooster
        case .owl🦉: return L10n.Creature.Option.Call.owl
        case .flamingo🦩: return L10n.Creature.Option.Call.flamingo
        case .swan🦢: return L10n.Creature.Option.Call.swan
        case .duck🦆: return L10n.Creature.Option.Call.duck
        case .bat🦇: return L10n.Creature.Option.Call.bat
        case .turtle🐢: return L10n.Creature.Option.Call.turtle
        case .crocodile🐊: return L10n.Creature.Option.Call.crocodile
        case .lizard🦎: return L10n.Creature.Option.Call.lizard
        case .snake🐍: return L10n.Creature.Option.Call.snake
        case .whale🐋: return L10n.Creature.Option.Call.whale
        case .dolphin🐬: return L10n.Creature.Option.Call.dolphin
        case .shark🦈: return L10n.Creature.Option.Call.shark
        case .octopus🐙: return L10n.Creature.Option.Call.octopus
        case .bug🐛: return L10n.Creature.Option.Call.bug
        case .butterfly🦋: return L10n.Creature.Option.Call.butterfly
        case .ant🐜: return L10n.Creature.Option.Call.ant
        case .honeybee🐝: return L10n.Creature.Option.Call.honeybee
        case .ladyBeetle🐞: return L10n.Creature.Option.Call.ladyBeetle
        case .spider🕷: return L10n.Creature.Option.Call.spider
        case .chipmunk🐿️: return L10n.Creature.Option.Call.chipmunk
        case .tiger🐅: return L10n.Creature.Option.Call.tiger
        case .zebra🦓: return L10n.Creature.Option.Call.zebra
        case .rhinoceros🦏: return L10n.Creature.Option.Call.rhinoceros
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
