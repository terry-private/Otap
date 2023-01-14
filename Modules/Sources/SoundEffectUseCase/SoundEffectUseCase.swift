//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import AVFoundation

public protocol SoundEffectUseCaseProtocol {
    static var correctSoundPlayer: AVAudioPlayer? { get }
    static var wrongSoundPlayer: AVAudioPlayer? { get }
    static func playCorrect()
    static func playWrong()
}

public enum SoundEffectUseCase: SoundEffectUseCaseProtocol {
    private static func resourceUrl(_ name: String) -> URL? {
        Bundle.module.url(forResource: name, withExtension: "mp3")
    }
    
    public static let correctSoundPlayer: AVAudioPlayer? = resourceUrl("correct").map { try! AVAudioPlayer(contentsOf: $0) }
    public static let wrongSoundPlayer: AVAudioPlayer? = resourceUrl("wrong").map { try! AVAudioPlayer(contentsOf: $0) }
    
    public static func playCorrect() {
        correctSoundPlayer?.play()
    }
    
    public static func playWrong() {
        wrongSoundPlayer?.play()
    }
}
