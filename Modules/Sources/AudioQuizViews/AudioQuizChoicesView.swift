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
    private let selectedIndex: Int?
    private let quiz: Quiz
    private let choiceTapped: (Int) -> Void
    private let getState: (Int) -> AudioQuizChoiceState
    
    private var itemCount: Int {
        if quiz.choices.count >= 9 {
            return 3
        } else {
            return 2
        }
    }
    
    public init(selectedIndex: Int?, quiz: Quiz, choiceTapped: @escaping (Int) -> Void, getState: @escaping (Int) -> AudioQuizChoiceState) {
        self.selectedIndex = selectedIndex
        self.quiz = quiz
        self.choiceTapped = choiceTapped
        self.getState = getState
    }
    
    public var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(), count: itemCount),
            spacing: 8
        ) {
            ForEach(Array(quiz.choices.enumerated()), id: \.element) { index, choice in
                Button {
                    choiceTapped(index)
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(choice.foregroundColor)
                        .opacity(selectedIndex == nil ? 1 : 0.5)
                        .overlay {
                            if let imageName = choice.imageName {
                                Image(imageName)
                            }
                        }
                        .shadow(color: .black.opacity(0.3), radius: 8)
                }
                .overlay {
                    switch getState(index) {
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
                .allowsHitTesting(selectedIndex == nil)
            }
        }
    }
}

struct AudioQuizChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        AudioQuizChoicesView(
            selectedIndex: nil,
            quiz: ColorQuiz(),
            choiceTapped: {_ in },
            getState: { _ in .unanswered }
        )
    }
}
