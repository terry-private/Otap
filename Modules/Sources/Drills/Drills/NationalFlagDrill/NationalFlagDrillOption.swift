//
//  NationalFlagDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/23.
//

import SwiftUI
import Core

public enum NationalFlagDrillOption: String {
    // アジア オセアニア
    case japan🇯🇵
    case korea🇰🇷
    case china🇨🇳
    case thailand🇹🇭
    
    case india🇮🇳
    case indonesia🇮🇩
    case singapore🇸🇬
    case australia🇦🇺
    
    // アメリカ大陸
    case unitedstate🇺🇸
    case canada🇨🇦
    case mexico🇲🇽
    case brazil🇧🇷
    
    case argentina🇦🇷
    case uruguay🇺🇾
    case peru🇵🇪
    case paraguay🇵🇾
    
    // ヨーロッパ
    case unitedkingdom🇬🇧
    case germany🇩🇪
    case france🇫🇷
    case italy🇮🇹
    
    case spain🇪🇸
    case portugal🇵🇹
    case russia🇷🇺
    case netherlands🇳🇱
    
    case switzerland🇨🇭
    case sweeden🇸🇪
    case norway🇳🇴
    case poland🇵🇱
    
    case belgium🇧🇪
    case greece🇬🇷
    case hungary🇭🇺
    case ukraine🇺🇦
    
    // アフリカ
    case cameroun🇨🇲
    case kenya🇰🇪
    case nigeria🇳🇬
    case southafrica🇿🇦
}

extension NationalFlagDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        .text(title: emoji)
    }
    
    public func call(_ language: String) -> String {
        switch self {
        case .japan🇯🇵: return localized("NationalFlag.Option.Call.japan", language) ?? "japan"
        case .korea🇰🇷: return localized("NationalFlag.Option.Call.korea", language) ?? "korea"
        case .china🇨🇳: return localized("NationalFlag.Option.Call.china", language) ?? "china"
        case .thailand🇹🇭: return localized("NationalFlag.Option.Call.thailand", language) ?? "thailand"
        case .india🇮🇳: return localized("NationalFlag.Option.Call.india", language) ?? "india"
        case .indonesia🇮🇩: return localized("NationalFlag.Option.Call.indonesia", language) ?? "indonesia"
        case .singapore🇸🇬: return localized("NationalFlag.Option.Call.singapore", language) ?? "singapore"
        case .australia🇦🇺: return localized("NationalFlag.Option.Call.australia", language) ?? "australia"
            
        case .argentina🇦🇷: return localized("NationalFlag.Option.Call.argentina", language) ?? "argentina"
        case .brazil🇧🇷: return localized("NationalFlag.Option.Call.brazil", language) ?? "brazil"
        case .uruguay🇺🇾: return localized("NationalFlag.Option.Call.uruguay", language) ?? "uruguay"
        case .unitedstate🇺🇸: return localized("NationalFlag.Option.Call.unitedstate", language) ?? "unitedstate"
        case .canada🇨🇦: return localized("NationalFlag.Option.Call.canada", language) ?? "canada"
        case .mexico🇲🇽: return localized("NationalFlag.Option.Call.mexico", language) ?? "mexico"
        case .peru🇵🇪: return localized("NationalFlag.Option.Call.peru", language) ?? "peru"
        case .paraguay🇵🇾: return localized("NationalFlag.Option.Call.paraguay", language) ?? "paraguay"
         
        case .unitedkingdom🇬🇧: return localized("NationalFlag.Option.Call.unitedkingdom", language) ?? "United Kingdom"
        case .germany🇩🇪: return localized("NationalFlag.Option.Call.germany", language) ?? "Germany"
        case .france🇫🇷: return localized("NationalFlag.Option.Call.france", language) ?? "France"
        case .italy🇮🇹: return localized("NationalFlag.Option.Call.italy", language) ?? "Italy"
        case .spain🇪🇸: return localized("NationalFlag.Option.Call.spain", language) ?? "Spain"
        case .portugal🇵🇹: return localized("NationalFlag.Option.Call.portugal", language) ?? "Portugal"
        case .russia🇷🇺: return localized("NationalFlag.Option.Call.russia", language) ?? "Russia"
            
        case .netherlands🇳🇱: return localized("NationalFlag.Option.Call.netherlands", language) ?? "netherlands"
        case .switzerland🇨🇭: return localized("NationalFlag.Option.Call.switzerland", language) ?? "switzerland"
        case .sweeden🇸🇪: return localized("NationalFlag.Option.Call.sweeden", language) ?? "sweeden"
        case .norway🇳🇴: return localized("NationalFlag.Option.Call.norway", language) ?? "norway"
        case .poland🇵🇱: return localized("NationalFlag.Option.Call.poland", language) ?? "poland"
        case .belgium🇧🇪: return localized("NationalFlag.Option.Call.belgium", language) ?? "belgium"
        case .greece🇬🇷: return localized("NationalFlag.Option.Call.greece", language) ?? "greece"
        case .hungary🇭🇺: return localized("NationalFlag.Option.Call.hungary", language) ?? "hungary"
        case .ukraine🇺🇦: return localized("NationalFlag.Option.Call.ukraine", language) ?? "ukraine"
            
        case .cameroun🇨🇲: return localized("NationalFlag.Option.Call.cameroun", language) ?? "cameroun"
        case .kenya🇰🇪: return localized("NationalFlag.Option.Call.kenya", language) ?? "kenya"
        case .nigeria🇳🇬: return localized("NationalFlag.Option.Call.nigeria", language) ?? "nigeria"
        case .southafrica🇿🇦: return localized("NationalFlag.Option.Call.southafrica", language) ?? "southafrica"
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 4)
    }
}

private extension NationalFlagDrillOption {
    var emoji: String {
        switch self {
        case .japan🇯🇵: return "🇯🇵"
        case .korea🇰🇷: return "🇰🇷"
        case .china🇨🇳: return "🇨🇳"
        case .thailand🇹🇭: return "🇹🇭"
        case .india🇮🇳: return "🇮🇳"
        case .indonesia🇮🇩: return "🇮🇩"
        case .singapore🇸🇬: return "🇸🇬"
        case .australia🇦🇺: return "🇦🇺"
            
        case .argentina🇦🇷: return "🇦🇷"
        case .brazil🇧🇷: return "🇧🇷"
        case .uruguay🇺🇾: return "🇺🇾"
        case .unitedstate🇺🇸: return "🇺🇸"
        case .canada🇨🇦: return "🇨🇦"
        case .mexico🇲🇽: return "🇲🇽"
        case .peru🇵🇪: return "🇵🇪"
        case .paraguay🇵🇾: return "🇵🇾"
            
        case .unitedkingdom🇬🇧: return "🇬🇧"
        case .germany🇩🇪: return "🇩🇪"
        case .france🇫🇷: return "🇫🇷"
        case .italy🇮🇹: return "🇮🇹"
        case .spain🇪🇸: return "🇪🇸"
        case .portugal🇵🇹: return "🇵🇹"
        case .russia🇷🇺: return "🇷🇺"
        case .netherlands🇳🇱: return "🇳🇱"
        case .switzerland🇨🇭: return "🇨🇭"
        case .sweeden🇸🇪: return "🇸🇪"
        case .norway🇳🇴: return "🇳🇴"
        case .poland🇵🇱: return "🇵🇱"
        case .belgium🇧🇪: return "🇧🇪"
        case .greece🇬🇷: return "🇬🇷"
        case .hungary🇭🇺: return "🇭🇺"
        case .ukraine🇺🇦: return "🇺🇦"
            
        case .cameroun🇨🇲: return "🇨🇲"
        case .kenya🇰🇪: return "🇰🇪"
        case .nigeria🇳🇬: return "🇳🇬"
        case .southafrica🇿🇦: return "🇿🇦"
        }
    }
}
