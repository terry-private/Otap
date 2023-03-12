//
//  SoundEffectInteractor.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

import AVFoundation

// MARK: - Interactor
public enum SoundEffectInteractor {
    // ---------------------------------
    // MARK: private static properties
    // ---------------------------------
    private static let correctSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("correct").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = 0.03
        return player
    }()
    
    private static let wrongSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("wrong").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = 0.03
        return player
    }()
    
    // --------------------------------
    // MARK: public static properties
    // --------------------------------
    static private var utteranceVolume: Float = 1
    static private var utteranceRate: Float = 0.4
    public static let speechSynthesizer: AVSpeechSynthesizer = {
        AVSpeechSynthesizer()
    }()
}

// MARK: - private methods
private extension SoundEffectInteractor {
    static func resourceUrl(_ name: String) -> URL? {
        Bundle.module.url(forResource: name, withExtension: "mp3")
    }
}

// MARK: - public methods
extension SoundEffectInteractor: SoundEffectUseCase {
    public static func readyAllPlayer() {
        _ = correctSoundPlayer
        _ = wrongSoundPlayer
        _ = speechSynthesizer
    }
    
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
        utterance.volume = utteranceVolume
        utterance.rate = utteranceRate
        speechSynthesizer.speak(utterance)
    }
}
