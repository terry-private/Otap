//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import AVFoundation

public protocol SoundEffectUseCaseProtocol {
    static func playCorrect()
    static func playWrong()
    static func speak(_ words: String)
}

public enum SoundEffectUseCase {
    // ---------------------------------
    // MARK: private static properties
    // ---------------------------------
    private static let correctSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("correct").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = 0.05
        return player
    }()
    
    private static let wrongSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("wrong").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = 0.05
        return player
    }()
    
    // --------------------------------
    // MARK: public static properties
    // --------------------------------
    public static let speechSynthesizer = AVSpeechSynthesizer()
}

// MARK: - private methods
private extension SoundEffectUseCase {
    static func resourceUrl(_ name: String) -> URL? {
        Bundle.module.url(forResource: name, withExtension: "mp3")
    }
}

// MARK: - public methods
extension SoundEffectUseCase: SoundEffectUseCaseProtocol {
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
    
    public static func speak(_ words: String) {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
        let utterance = AVSpeechUtterance(string: words)
        speechSynthesizer.speak(utterance)
    }
}
