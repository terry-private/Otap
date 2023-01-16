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
    
    public static let correctSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("correct").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = 0.05
        return player
    }()
    
    public static let wrongSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("wrong").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = 0.05
        return player
    }()
    
    public static func playCorrect() {
        if correctSoundPlayer?.isPlaying == true {
            correctSoundPlayer?.stop()
        }
        correctSoundPlayer?.play()
    }
    
    public static func playWrong() {
        if wrongSoundPlayer?.isPlaying == true {
            wrongSoundPlayer?.stop()
        }
        wrongSoundPlayer?.play()
    }
}
