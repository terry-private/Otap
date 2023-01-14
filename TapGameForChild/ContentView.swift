//
//  ContentView.swift
//  TapGameForChild
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import AVFoundation
import SoundEffectUseCase
import OrientationAdaptiveStackView
import TapGame

public enum OptionState {
    case unresolved
    case unselected
    case correct
    case wrong
}

struct ContentView<Game: TapGame>: View {
    private let paddingSize: CGFloat = 16
    private let cellSpacing: CGFloat = 8
    
    @State var tappedOption: Game.Option?
    @State var game: Game
    let speechSynthesizer = AVSpeechSynthesizer()
    init(game: Game = ColorGame()) {
        self._game = .init(wrappedValue: game)
    }
    var body: some View {
        GeometryReader { proxy in
            let sideLength = (min(proxy.size.width, proxy.size.height) - paddingSize * 2 - cellSpacing) / 2
            ZStack {
                OrientationAdaptiveStackView {
                    Button {
                        guard !speechSynthesizer.isSpeaking else { return }
                        speakAnswer()
                    } label: {
                        Image(systemName: "speaker.wave.2.circle")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.blue)
                    }
                    .padding(40)
                    
                    Spacer()
                }
                
                OrientationAdaptiveStackView {
                    Spacer()
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(sideLength)),
                            GridItem(.fixed(sideLength))
                        ],
                        spacing: cellSpacing
                    ) {
                        ForEach(game.options, id: \.self) { option in
                            Button {
                                guard tappedOption == nil else {
                                    return
                                }
                                tappedOption = option
                                playSoundEffect()
                                Task { @MainActor in
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    game = ColorGame() as! Game
                                    tappedOption = nil
                                    speakAnswer()
                                }
                            } label: {
                                VStack {
                                    if let imageName = option.imageName {
                                        Image(imageName)
                                    }
                                }
                                .frame(width: sideLength, height: sideLength)
                                .background {
                                    RoundedRectangle(cornerRadius: cellSpacing)
                                        .foregroundColor(option.foregroundColor)
                                        .opacity(tappedOption == nil ? 1 : 0.5)
                                }
                                .overlay {
                                    switch optionState(option) {
                                    case .correct:
                                        Image(systemName: "circle")
                                            .resizable()
                                            .foregroundColor(.red)
                                            .padding()
                                            .shadow(color: .black.opacity(0.2), radius: 8)
                                    case .wrong:
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .foregroundColor(.red)
                                            .padding()
                                            .shadow(color: .black.opacity(0.2), radius: 8)
                                    default:
                                        EmptyView()
                                    }
                                }
                            }
                            .allowsHitTesting(tappedOption == nil)
                        }
                    }
                    .padding(paddingSize)
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            speakAnswer()
        }
    }
    
    func optionState(_ option: Game.Option) -> OptionState {
        guard let tappedOption else {
            return .unresolved
        }
        guard tappedOption == option else {
            return .unselected
        }
        if game.answer == option {
            return .correct
        } else {
            return .wrong
        }
    }
    
    func speakAnswer() {
        let utterance = AVSpeechUtterance(string: game.answer.call)
        speechSynthesizer.speak(utterance)
    }
    
    func playSoundEffect() {
        if game.answer == tappedOption {
            SoundEffectUseCase.playCorrect()
        } else {
            SoundEffectUseCase.playWrong()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
