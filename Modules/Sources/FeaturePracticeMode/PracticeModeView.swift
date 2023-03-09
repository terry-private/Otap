//
//  PracticeModeView.swift
//  
//
//  Created by 若江照仁 on 2023/03/09.
//

import SwiftUI
import Core
import Utility

public struct PracticeModeView<Quiz: VoiceQuiz, SoundEffect: SoundEffectUseCase>: View {
    let rows = Quiz.Option.practiceRows
    public init() {}
    public var body: some View {
        ScrollView {
            Grid {
                ForEach(rows.indices, id: \.self) { rowIndex in
                    rowView(rows[rowIndex])
                }
            }
            .padding(16)
        }
        .background {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
        }
        .navigationTitle("\(Quiz.title)")
    }
}

private extension PracticeModeView {
    @ViewBuilder
    func rowView(_ row: [Quiz.Option]) -> some View {
        GridRow {
            ForEach(row) { option in
                Button {
                    SoundEffect.speak(option.call)
                } label: {
                    option.viewType.view()
                        .aspectRatio(1, contentMode: .fill)
                        .cornerRadius(8)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: .init(lineWidth: 1))
                                .foregroundColor(.init(uiColor: .opaqueSeparator))
                        }
                }
            }
        }
    }
}

#if DEBUG
struct PracticeModeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PracticeModeView<VoiceQuizDummy, SoundEffectUseCaseDummy>()
        }
    }
}
#endif
