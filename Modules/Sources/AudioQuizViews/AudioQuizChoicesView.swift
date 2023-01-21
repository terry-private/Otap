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
    
    private let columnsCount: Int
    private let itemSize: CGFloat
    
    public init(_ size: CGSize, selectedIndex: Int?, quiz: Quiz, choiceTapped: @escaping (Int) -> Void, getState: @escaping (Int) -> AudioQuizChoiceState) {
        self.selectedIndex = selectedIndex
        self.quiz = quiz
        self.choiceTapped = choiceTapped
        self.getState = getState
        
        let columnsCount = quiz.choices.count >= 9 ? 3 : 2
        self.columnsCount = columnsCount
        
        let rowsCount = quiz.choices.count / columnsCount
        let height = (size.height - 8 * CGFloat(rowsCount - 1)) / CGFloat(rowsCount)
        let width = (size.width - 8 * CGFloat(columnsCount - 1)) / CGFloat(columnsCount)
        itemSize = min(height, width, 250)
        print("🐱", "width: ", width, ", height: ", height)
    }
    
    public var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.fixed(itemSize)), count: columnsCount),
            spacing: 8
        ) {
            ForEach(Array(quiz.choices.enumerated()), id: \.element) { index, choice in
                Button {
                    choiceTapped(index)
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(choice.foregroundColor)
                        .overlay {
                            if let imageName = choice.imageName {
                                Image(imageName)
                            }
                        }
                        .shadow(color: .black.opacity(0.2), radius: 8)
                }
                .opacity(selectedIndex == nil ? 1 : 0.2)
                .overlay {
                    switch getState(index) {
                    case .correct:
                        Image(systemName: "circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .foregroundColor(.red)
                            .padding()
                            .shadow(color: .black.opacity(0.2), radius: 8)
                    case .wrong:
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .scaledToFill()
                            .foregroundColor(.red)
                            .padding()
                            .shadow(color: .black.opacity(0.2), radius: 8)
                    default:
                        EmptyView()
                    }
                }
                .allowsHitTesting(selectedIndex == nil)
                .transition(.identity)
            }
        }
    }
}

struct AudioQuizChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        AudioQuizChoicesView(
            .init(width: 300, height: 800),
            selectedIndex: nil,
            quiz: ColorQuiz(),
            choiceTapped: {_ in },
            getState: { _ in .unanswered }
        )
    }
}
