//
//  UtteranceLanguage.swift
//  
//
//  Created by 若江照仁 on 2023/03/19.
//

import Foundation

public enum UtteranceLanguage: String, CaseIterable {
    case system = "system"
    case english = "en"
    case japanese = "ja"
    
    public var code: String {
        switch self {
        case .system:
            return Locale.current.language.languageCode?.identifier ?? "en"
        default:
            return rawValue
        }
    }
}
