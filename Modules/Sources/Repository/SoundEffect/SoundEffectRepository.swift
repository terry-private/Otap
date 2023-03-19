//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/19.
//

import Foundation
import Core

public protocol SoundEffectRepository {
    static var effectVolume: Float { get set }
    static var utteranceVolume: Float { get set }
    static var utteranceLanguage: UtteranceLanguage { get set }
}
