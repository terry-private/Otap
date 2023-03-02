//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import SwiftUI
import Extensions
import Core

public enum CreatureQuizOption: String {
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

extension CreatureQuizOption: VoiceQuizOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        .text(title: emoji, textColor: .init(uiColor: .label), backgroundColor: .init(uiColor: .systemFill))
    }
    
    public var call: String {
        switch self {
        case .dog🐕: return "いぬ"
        case .cat🐈: return "ねこ"
        case .mouse🐁: return "ねずみ"
        case .cow🐄: return "うし"
        case .rabbit🐇: return "うさぎ"
        case .horse🐎: return "うま"
        case .elephant🐘: return "ぞう"
        case .pig🐖: return "ぶた"
        case .camel🐪: return "らくだ"
        case .giraffe🦒: return "きりん"
        case .kangaroo🦘: return "かんがるー"
        case .monkey🐒: return "さる"
        case .rooster🐓: return "にわとり"
        case .owl🦉: return "ふくろう"
        case .flamingo🦩: return "ふらみんご"
        case .swan🦢: return "はくちょう"
        case .duck🦆: return "かも"
        case .bat🦇: return "こうもり"
        case .turtle🐢: return "かめ"
        case .crocodile🐊: return "わに"
        case .lizard🦎: return "とかげ"
        case .snake🐍: return "へび"
        case .whale🐋: return "くじら"
        case .dolphin🐬: return "いるか"
        case .shark🦈: return "さめ"
        case .octopus🐙: return "たこ"
        case .bug🐛: return "けむし"
        case .butterfly🦋: return "ちょうちょ"
        case .ant🐜: return "あり"
        case .honeybee🐝: return "みつばち"
        case .ladyBeetle🐞: return "てんとうむし"
        case .spider🕷: return "くも"
        case .chipmunk🐿️: return "りす"
        case .tiger🐅: return "とら"
        case .zebra🦓: return "しまうま"
        case .rhinoceros🦏: return "さい"
        }
    }
}
 
private extension CreatureQuizOption {
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
