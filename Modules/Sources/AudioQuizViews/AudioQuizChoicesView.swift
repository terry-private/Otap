//
//  AudioQuizChoicesView.swift
//  
//
//  Created by 若江照仁 on 2023/01/16.
//

import SwiftUI
import OrientationAdaptiveViews
import AudioQuiz

public struct AudioQuizChoicesView<Quiz: AudioQuiz>: View {
    private let selectedChoice: Quiz.Choice?
    private let quiz: Quiz
    private let choiceTapped: (Quiz.Choice) -> Void
    private let getState: (Quiz.Choice) -> AudioQuizChoiceState
    
    public init(selectedChoice: Quiz.Choice?, quiz: Quiz, choiceTapped: @escaping (Quiz.Choice) -> Void, getState: @escaping (Quiz.Choice) -> AudioQuizChoiceState) {
        self.selectedChoice = selectedChoice
        self.quiz = quiz
        self.choiceTapped = choiceTapped
        self.getState = getState
    }
    
    public var body: some View {
        OALazyGridView(
            gridItems: Array(repeating: GridItem(), count: 3),
            spacing: 8
        ) {
            ForEach(quiz.choices, id: \.self) { option in
                Button {
                    choiceTapped(option)
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(option.foregroundColor)
                        .opacity(selectedChoice == nil ? 1 : 0.5)
                        .overlay {
                            if let imageName = option.imageName {
                                Image(imageName)
                            }
                        }
                        .shadow(color: .black.opacity(0.3), radius: 8)
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
                .allowsHitTesting(selectedChoice == nil)
            }
        }
    }
}

struct AudioQuizChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        AudioQuizChoicesView(selectedChoice: nil, quiz: ColorQuiz(), choiceTapped: {_ in }, getState: { _ in .unanswered })
    }
}
