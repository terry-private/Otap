//
//  SoundEffectUseCase.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//
import Foundation

public enum LocalizeType {
    case system
    case specific(Locale.Language)
}

// MARK: - UseCaseProtocol
public protocol SoundEffectUseCase {
    static var effectVolume: Float { get set }
    static var utteranceVolume: Float { get set }
    static var utteranceLanguage: String { get set }
    static func readyAllPlayer()
    static func playCorrect()
    static func playWrong()
    static func speak(_ words: String, _ specificLanguage: String?)
}

#if DEBUG
public enum SoundEffectUseCaseDummy: SoundEffectUseCase {
    public static var effectVolume: Float = 1
    
    public static var utteranceVolume: Float = 1
    public static var utteranceLanguage: String = "ja"
    public static func readyAllPlayer() {
        print(#file, #function)
    }
    
    public static func playCorrect() {
        print(#file, #function)
    }
    
    public static func playWrong() {
        print(#file, #function)
    }
    
    public static func speak(_ words: String, _ specificLanguage: String?) {
        print(#file, #function, words)
    }
}
#endif
