//
//  SoundEffectInteractor.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

import AVFoundation
import Core
import Repository

// MARK: - Interactor
public enum SoundEffectInteractor {
    typealias repository = RepositoryImpl
    private static let effectVolumeRate: Float = 0.04
    // ---------------------------------
    // MARK: private static properties
    // ---------------------------------
    private static let correctSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("correct").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = repository.effectVolume * effectVolumeRate
        return player
    }()
    
    private static let wrongSoundPlayer: AVAudioPlayer? = {
        let player = resourceUrl("wrong").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil
        player?.volume = repository.effectVolume * effectVolumeRate
        return player
    }()
    
    // --------------------------------
    // MARK: public static properties
    // --------------------------------
    public static var utteranceVolume: Float {
        get {
            repository.utteranceVolume
        }
        set {
            repository.utteranceVolume = newValue
        }
    }
    
    public static let speechSynthesizer: AVSpeechSynthesizer = {
        AVSpeechSynthesizer()
    }()
    
    public static var utteranceLanguage: UtteranceLanguage {
        get {
            repository.utteranceLanguage
        }
        set {
            repository.utteranceLanguage = newValue
        }
    }
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
    
    public static var effectVolume: Float {
        get {
            (correctSoundPlayer?.volume ?? 0) / effectVolumeRate
        }
        set {
            correctSoundPlayer?.volume = newValue * effectVolumeRate
            wrongSoundPlayer?.volume = newValue * effectVolumeRate
            repository.effectVolume = newValue
        }
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
    
    public static func speak(_ words: String, _ specificLanguage: String) {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
        let utterance = AVSpeechUtterance(string: words)
        utterance.volume = utteranceVolume
        utterance.rate = words.count == 1 ? 0.3 : 0.4
        utterance.voice = AVSpeechSynthesisVoice(language: specificLanguage)
        speechSynthesizer.speak(utterance)
    }
}
