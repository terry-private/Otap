//
//  SelectLevelView.swift
//  
//
//  Created by 若江照仁 on 2023/02/10.
//

import SwiftUI
import Core
import Components

public struct SelectLevelView: View {
    struct Cell<Quiz: SoundQuiz>: View {
        var quiz: Quiz
        var body: some View {
            HStack {
                SquareGrid(quiz.options) { option in
                    Rectangle()
                        .fill(option.foregroundColor.gradient)
                }
            }
        }
    }
    public var body: some View {
        ScrollView {
            LazyVStack {
                Cell(quiz: ColorQuiz(options: [.red, .yellow, .blue, .green]))
            }
            .padding()
        }
        .background {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
        }
    }
}

struct SelectLevelView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLevelView()
    }
}
