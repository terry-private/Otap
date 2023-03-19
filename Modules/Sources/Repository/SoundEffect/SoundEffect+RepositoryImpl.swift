//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/19.
//

import Core
import Data

extension RepositoryImpl: SoundEffectRepository {
    public static var effectVolume: Float {
        get {
            UserDefaultsClient.effectVolume
        }
        set {
            UserDefaultsClient.effectVolume = newValue
        }
    }
    
    public static var utteranceVolume: Float {
        get {
            UserDefaultsClient.utteranceVolume
        }
        set {
            UserDefaultsClient.utteranceVolume = newValue
        }
    }
    
    public static var utteranceLanguage: UtteranceLanguage {
        get {
            .init(rawValue: UserDefaultsClient.utteranceLanguage) ?? .system
        }
        set {
            UserDefaultsClient.utteranceLanguage = newValue.rawValue
        }
    }
}
