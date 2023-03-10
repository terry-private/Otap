//
//  VehicleDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/04.
//

import Core

public enum VehicleDrillOption: String {
    case highSpeedTrain🚄
    case train🚃
    case locomotive🚂
    case airPlane🛩
    
    case bus🚌
    case ambulance🚑
    case fireEngine🚒
    case policeCar🚓
    
    case taxi🚕
    case truck🚛
    case bike🏍
    case bicycle🚲
}

extension VehicleDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        switch self {
        case .highSpeedTrain🚄: return .text(title: "🚄")
        case .train🚃: return .text(title: "🚃")
        case .locomotive🚂: return .text(title: "🚂")
        case .airPlane🛩: return .text(title: "🛩")
        case .bus🚌: return .text(title: "🚌")
        case .ambulance🚑: return .text(title: "🚑")
        case .fireEngine🚒: return .text(title: "🚒")
        case .policeCar🚓: return .text(title: "🚓")
        case .taxi🚕: return .text(title: "🚕")
        case .truck🚛: return .text(title: "🚛")
        case .bike🏍: return .text(title: "🏍")
        case .bicycle🚲: return .text(title: "🚲")
        }
    }
    
    public var call: String {
        switch self {
        case .highSpeedTrain🚄: return "新幹線"
        case .train🚃: return "電車"
        case .locomotive🚂: return "汽車"
        case .airPlane🛩: return "飛行機"
        case .bus🚌: return "バス"
        case .ambulance🚑: return "救急車"
        case .fireEngine🚒: return "消防車"
        case .policeCar🚓: return "パトカー"
        case .taxi🚕: return "タクシー"
        case .truck🚛: return "トラック"
        case .bike🏍: return "バイク"
        case .bicycle🚲: return "自転車"
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 3)
    }
}
