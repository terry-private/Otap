//
//  ContentView.swift
//  TapGameForChild
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import AVFoundation

public protocol TapOption: Hashable {
    var foregroundColor: Color { get }
    var call: String { get }
    var imageName: String? { get }
}

public protocol TapGame<Option> {
    associatedtype Option: TapOption
    var options: [Option] { get }
    var answer: Option { get }
}

public struct ColorGame: TapGame {
    public enum ColorOption: TapOption, CaseIterable {
        case red
        case blue
        case green
        case yellow
        case purple
        case pink
        case orange
        case brown
        
        public var foregroundColor: Color {
            switch self {
            case .red: return .red
            case .blue: return .blue
            case .green: return .green
            case .yellow: return .yellow
            case .purple: return .purple
            case .pink: return .pink
            case .orange: return .orange
            case .brown: return .brown
            }
        }
        
        public var call: String {
            switch self {
            case .red: return "あか"
            case .blue: return "あお"
            case .green: return "みどり"
            case .yellow: return "きいろ"
            case .purple: return "むらさき"
            case .pink: return "ぴんく"
            case .orange: return "おれんじ"
            case .brown: return "ちゃいろ"
            }
        }
        
        public var imageName: String? { nil }
    }
    
    public var options: [ColorOption]
    public var answer: ColorOption
    
    public init(
        options: [ColorOption] = ColorOption.allCases
            .shuffled()
            .prefix(4)
            .map{ $0 }
    ) {
        self.options = options
        answer = options.randomElement()!
    }
}

public enum AfterOptionState {
    case unselected
    case correct
    case wrong
}

struct ContentView<Game: TapGame>: View {
    private let paddingSize: CGFloat = 16
    private let cellSpacing: CGFloat = 8
    
    @State var player: AVAudioPlayer
    @State var tappedOption: Game.Option?
    @State var game: Game
    let speechSynthesizer = AVSpeechSynthesizer()
    init(game: Game = ColorGame()) {
        self._game = .init(wrappedValue: game)
        let soundURL = Bundle.main.url(forResource: "correct", withExtension: "mp3")!
        self._player = .init(wrappedValue: try! AVAudioPlayer(contentsOf: soundURL))
    }
    var body: some View {
        GeometryReader { proxy in
            let sideLength = (min(proxy.size.width, proxy.size.height) - paddingSize * 2 - cellSpacing) / 2
            ZStack {
                OrientationAdaptiveStack {
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
                
                OrientationAdaptiveStack {
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
                                    switch afterOptionState(option: option) {
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
                                    case .unselected:
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
    
    func afterOptionState(option: Game.Option) -> AfterOptionState {
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
        let fileName = game.answer == tappedOption ? "correct" : "wrong"
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player.play()
            } catch {
                print("error")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
