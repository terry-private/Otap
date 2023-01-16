//
//  TapOptionsView.swift
//  
//
//  Created by 若江照仁 on 2023/01/16.
//

import SwiftUI
import OrientationAdaptiveViews

public struct TapOptionsView<Game: TapGame>: View {
    private let tappedOption: Game.Option?
    private let game: Game
    private let optionTapped: (Game.Option) -> Void
    private let getState: (Game.Option) -> OptionState
    
    public init(tappedOption: Game.Option?, game: Game, optionTapped: @escaping (Game.Option) -> Void, getState: @escaping (Game.Option) -> OptionState) {
        self.tappedOption = tappedOption
        self.game = game
        self.optionTapped = optionTapped
        self.getState = getState
    }
    
    public var body: some View {
        OALazyGridView(
            gridItems: Array(repeating: GridItem(), count: 3),
            spacing: 8
        ) {
            ForEach(game.options, id: \.self) { option in
                Button {
                    optionTapped(option)
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(option.foregroundColor)
                        .opacity(tappedOption == nil ? 1 : 0.5)
                        .overlay {
                            if let imageName = option.imageName {
                                Image(imageName)
                            }
                        }
                }
                .overlay {
                    switch getState(option) {
                    case .correct:
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.red)
                            .padding()
                            .shadow(color: .black.opacity(0.2), radius: 8)
                    case .wrong:
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .foregroundColor(.red)
                            .padding()
                            .shadow(color: .black.opacity(0.2), radius: 8)
                    default:
                        EmptyView()
                    }
                }
                .allowsHitTesting(tappedOption == nil)
            }
        }
    }
}

struct TapOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        TapOptionsView(tappedOption: nil, game: ColorGame(), optionTapped: {_ in }, getState: { _ in .unanswered })
    }
}
