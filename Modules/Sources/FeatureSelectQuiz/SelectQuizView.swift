//
//  SelectQuizView.swift
//  
//
//  Created by 若江照仁 on 2023/02/26.
//

import SwiftUI
import Core
import CoreImpl
import Components
import Feature
import ViewFactoryImpl
import Utility

public struct SelectQuizView: View {
    @State var count: Int = 0
    public init() {}
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                navigationCell(ColorQuizLevelSelector.level3)
                navigationCell(AnimalQuizLevelSelector.funny1)
            }
            .padding(16)
        }
        .navigationTitle("クイズを選択")
        .onAppear {
            SoundEffectInteractor.readyAllPlayer()
        }
    }
    
    @MainActor // for ViewModel.init()
    func navigationCell<T: VoiceQuizLevelSelector>(_ selector: T) -> some View {
        NavigationLink {
            SelectLevelView<SelectLevelViewFactoryImpl<T>>(viewModel: .init())
        } label: {
            VStack(spacing: 5) {
                Text(T.Quiz.title)
                    .font(.title3)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.init(uiColor: .label))
                
                SquareGrid(selector.generator.previewQuiz.options) { option in
                    option.viewType.view()
                }
                .aspectRatio(1, contentMode: .fill)
            }
            .padding(16)
            .background {
                Color(uiColor: .tertiarySystemBackground)
            }
            .cornerRadius(16)
            .shadow(radius: 4)
        }
    }
}

struct SelectQuizView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuizView()
    }
}
