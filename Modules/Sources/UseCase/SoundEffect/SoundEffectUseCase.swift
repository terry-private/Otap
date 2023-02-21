//
//  SoundEffectUseCase.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

// MARK: - UseCaseProtocol
public protocol SoundEffectUseCase {
    static func playCorrect()
    static func playWrong()
    static func speak(_ words: String)
}

#if DEBUG
public enum SoundEffectUseCaseDummy: SoundEffectUseCase {
    public static func playCorrect() {
        print(#file, #function)
    }
    
    public static func playWrong() {
        print(#file, #function)
    }
    
    public static func speak(_ words: String) {
        print(#file, #function, words)
    }
}
#endif
