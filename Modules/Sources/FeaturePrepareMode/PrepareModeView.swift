//
//  PrepareModeView.swift
//  
//
//  Created by 若江照仁 on 2023/03/09.
//

import SwiftUI
import Core
import Utility

public struct PrepareModeView<Drill: CoreDrill, SoundEffect: SoundEffectUseCase>: View {
    let rows = Drill.Option.practiceRows
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
        .navigationTitle("\(Drill.title)")
    }
}

private extension PrepareModeView {
    @ViewBuilder
    func rowView(_ row: [Drill.Option]) -> some View {
        GridRow {
            ForEach(row) { option in
                Button {
                    let callLanguage = Drill.specificLanguage?.minimalIdentifier ?? SoundEffect.utteranceLanguage
                    SoundEffect.speak(option.call(callLanguage), callLanguage)
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
struct PrepareModeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrepareModeView<DrillDummy, SoundEffectUseCaseDummy>()
        }
    }
}
#endif
