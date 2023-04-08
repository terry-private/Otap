//
//  SoundEffectInteractor.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

import AVFoundation
import Core
import Repository

// ---------------------------------
// MARK: private constant properties
// ---------------------------------

private let effectVolumeRate: Float = 0.04
private let shortWords: Set<String> = .init(["あ", "い", "う", "え", "お"])

private let correctSoundPlayer: AVAudioPlayer? = {
    let player = resourceUrl("correct").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil // unwrap double Optional
    return player
}()

private let wrongSoundPlayer: AVAudioPlayer? = {
    let player = resourceUrl("wrong").map { try? AVAudioPlayer(contentsOf: $0) } ?? nil // unwrap double Optional
    return player
}()

private let speechSynthesizer: AVSpeechSynthesizer = {
    AVSpeechSynthesizer()
}()

// ---------------------------------
// MARK: private function
// ---------------------------------
private func resourceUrl(_ name: String) -> URL? {
    Bundle.module.url(forResource: name, withExtension: "mp3")
}

// MARK: - Interactor
public enum SoundEffectInteractor<Repository: SoundEffectRepository> {
    typealias repository = Repository
    
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
    public static var utteranceLanguage: UtteranceLanguage {
        get {
            repository.utteranceLanguage
        }
        set {
            repository.utteranceLanguage = newValue
        }
    }
}

// MARK: - public methods
extension SoundEffectInteractor: SoundEffectUseCase {
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
        correctSoundPlayer?.volume = repository.effectVolume * effectVolumeRate
        correctSoundPlayer?.play()
    }
    
    public static func playWrong() {
        if wrongSoundPlayer?.isPlaying == true {
            wrongSoundPlayer?.stop()
        }
        wrongSoundPlayer?.volume = repository.effectVolume * effectVolumeRate
        wrongSoundPlayer?.play()
    }
    
    public static func speak(_ words: String, _ specificLanguage: String) {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
        let utterance = AVSpeechUtterance(string: words)
        utterance.voice = AVSpeechSynthesisVoice(language: specificLanguage)
        utterance.volume = utteranceVolume
        utterance.rate = shortWords.contains(words) ? 0.2 : 0.4
        
        speechSynthesizer.speak(utterance)
    }
}
