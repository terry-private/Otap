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
    case bangladesh🇧🇩
    
    case iraq🇮🇶
    case iran🇮🇷
    case cambodia🇰🇭
    case saudiarabia🇸🇦
    
    case malaysia🇲🇾
    case nepal🇳🇵
    case philippines🇵🇭
    case pakistan🇵🇰
    
    case turkey🇹🇷
    case vietnam🇻🇳
    case australia🇦🇺
    case newzealand🇳🇿
    
    // アメリカ大陸
    case unitedstate🇺🇸
    case canada🇨🇦
    case mexico🇲🇽
    case brazil🇧🇷
    
    case argentina🇦🇷
    case uruguay🇺🇾
    case peru🇵🇪
    case paraguay🇵🇾
    
    case colombia🇨🇴
    case jamaica🇯🇲
    case chile🇨🇱
    case cuba🇨🇺
    
    case costarica🇨🇷
    case panama🇵🇦
    case ecuador🇪🇨
    case venezuela🇻🇪
    
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
    
    case austria🇦🇹
    case denmark🇩🇰
    case finland🇫🇮
    case ireland🇮🇪
    
    case iceland🇮🇸
    case croatia🇭🇷
    case slovakia🇸🇰
    case czech🇨🇿
    
    // アフリカ
    case cameroun🇨🇲
    case kenya🇰🇪
    case nigeria🇳🇬
    case southafrica🇿🇦
    
    case senegal🇸🇳
    case egypt🇪🇬
    case ghana🇬🇭
    case morocco🇲🇦
    
    case tunisia🇹🇳
    case ethiopia🇪🇹
    case algeria🇩🇿
    case cotedIvoire🇨🇮
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
        case .bangladesh🇧🇩: return localized("NationalFlag.Option.Call.bangladesh", language) ?? "bangladesh"
        case .iraq🇮🇶: return localized("NationalFlag.Option.Call.iraq", language) ?? "iraq"
        case .iran🇮🇷: return localized("NationalFlag.Option.Call.iran", language) ?? "iran"
        case .cambodia🇰🇭: return localized("NationalFlag.Option.Call.cambodia", language) ?? "cambodia"
        case .saudiarabia🇸🇦: return localized("NationalFlag.Option.Call.saudiarabia", language) ?? "saudiarabia"
        case .malaysia🇲🇾: return localized("NationalFlag.Option.Call.malaysia", language) ?? "malaysia"
        case .nepal🇳🇵: return localized("NationalFlag.Option.Call.nepal", language) ?? "nepal"
        case .philippines🇵🇭: return localized("NationalFlag.Option.Call.philippines", language) ?? "philippines"
        case .pakistan🇵🇰: return localized("NationalFlag.Option.Call.pakistan", language) ?? "pakistan"
        case .turkey🇹🇷: return localized("NationalFlag.Option.Call.turkey", language) ?? "turkey"
        case .vietnam🇻🇳: return localized("NationalFlag.Option.Call.vietnam", language) ?? "vietnam"
        case .australia🇦🇺: return localized("NationalFlag.Option.Call.australia", language) ?? "australia"
        case .newzealand🇳🇿: return localized("NationalFlag.Option.Call.newzealand", language) ?? "newzealand"
            
        case .argentina🇦🇷: return localized("NationalFlag.Option.Call.argentina", language) ?? "argentina"
        case .brazil🇧🇷: return localized("NationalFlag.Option.Call.brazil", language) ?? "brazil"
        case .uruguay🇺🇾: return localized("NationalFlag.Option.Call.uruguay", language) ?? "uruguay"
        case .unitedstate🇺🇸: return localized("NationalFlag.Option.Call.unitedstate", language) ?? "unitedstate"
        case .canada🇨🇦: return localized("NationalFlag.Option.Call.canada", language) ?? "canada"
        case .mexico🇲🇽: return localized("NationalFlag.Option.Call.mexico", language) ?? "mexico"
        case .peru🇵🇪: return localized("NationalFlag.Option.Call.peru", language) ?? "peru"
        case .paraguay🇵🇾: return localized("NationalFlag.Option.Call.paraguay", language) ?? "paraguay"
            
        case .colombia🇨🇴: return localized("NationalFlag.Option.Call.colombia", language) ?? "colombia"
        case .jamaica🇯🇲: return localized("NationalFlag.Option.Call.jamaica", language) ?? "jamaica"
        case .chile🇨🇱: return localized("NationalFlag.Option.Call.chile", language) ?? "chile"
        case .cuba🇨🇺: return localized("NationalFlag.Option.Call.cuba", language) ?? "cuba"
            
        case .costarica🇨🇷: return localized("NationalFlag.Option.Call.costarica", language) ?? "costarica"
        case .panama🇵🇦: return localized("NationalFlag.Option.Call.panama", language) ?? "panama"
        case .ecuador🇪🇨: return localized("NationalFlag.Option.Call.ecuador", language) ?? "ecuador"
        case .venezuela🇻🇪: return localized("NationalFlag.Option.Call.venezuela", language) ?? "venezuela"
            
            
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
            
        case .austria🇦🇹: return localized("NationalFlag.Option.Call.austria", language) ?? "austria"
        case .denmark🇩🇰: return localized("NationalFlag.Option.Call.denmark", language) ?? "denmark"
        case .finland🇫🇮: return localized("NationalFlag.Option.Call.finland", language) ?? "finland"
        case .ireland🇮🇪: return localized("NationalFlag.Option.Call.island", language) ?? "island"
            
        case .iceland🇮🇸: return localized("NationalFlag.Option.Call.iceland", language) ?? "iceland"
        case .croatia🇭🇷: return localized("NationalFlag.Option.Call.croatia", language) ?? "croatia"
        case .slovakia🇸🇰: return localized("NationalFlag.Option.Call.slovakia", language) ?? "slovakia"
        case .czech🇨🇿: return localized("NationalFlag.Option.Call.czech", language) ?? "czech"
            
        case .cameroun🇨🇲: return localized("NationalFlag.Option.Call.cameroun", language) ?? "cameroun"
        case .kenya🇰🇪: return localized("NationalFlag.Option.Call.kenya", language) ?? "kenya"
        case .nigeria🇳🇬: return localized("NationalFlag.Option.Call.nigeria", language) ?? "nigeria"
        case .southafrica🇿🇦: return localized("NationalFlag.Option.Call.southafrica", language) ?? "southafrica"
            
        case .senegal🇸🇳: return localized("NationalFlag.Option.Call.senegal", language) ?? "senegal"
        case .egypt🇪🇬: return localized("NationalFlag.Option.Call.egypt", language) ?? "egypt"
        case .ghana🇬🇭: return localized("NationalFlag.Option.Call.ghana", language) ?? "ghana"
        case .morocco🇲🇦: return localized("NationalFlag.Option.Call.morocco", language) ?? "morocco"
            
        case .tunisia🇹🇳: return localized("NationalFlag.Option.Call.tunisia", language) ?? "tunisia"
        case .ethiopia🇪🇹: return localized("NationalFlag.Option.Call.ethiopia", language) ?? "ethiopia"
        case .algeria🇩🇿: return localized("NationalFlag.Option.Call.algeria", language) ?? "algeria"
        case .cotedIvoire🇨🇮: return localized("NationalFlag.Option.Call.cotedIvoire", language) ?? "cotedIvoire"
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 4)
    }
}

private extension NationalFlagDrillOption {
    var emoji: String {
        String(self.rawValue.suffix(1))
    }
}
