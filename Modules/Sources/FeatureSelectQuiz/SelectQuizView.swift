//
//  SelectQuizView.swift
//  
//
//  Created by 若江照仁 on 2023/02/26.
//

import SwiftUI
import Core
import Components

public struct SelectQuizView<Factory: SelectQuizViewFactoryProtocol>: View {
    @StateObject var viewModel: Factory.ViewModel
    @State var columnsCount: Int = 0
    
    @MainActor
    public init() {
        let viewModel = Factory.viewModel
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: .init(repeating: .init(), count: columnsCount)) {
                ForEach(viewModel.selectors.indices, id: \.self) { index in
                    navigationCell(viewModel.selectors[index])
                }
            }
            .padding(16)
        }
        .onChangeFrame { size in
            columnsCount = max(Int(size.width / 300), 2)
        }
        .navigationTitle("クイズを選択")
        .background {
            Color(uiColor: .secondarySystemBackground).ignoresSafeArea()
        }
    }
    
    @MainActor
    private func navigationCell(_ selector: any VoiceQuizLevelSelector) -> some View {
        makeNavigationLink(selector).toAnyView()
    }
    
    @MainActor // for ViewModel.init()
    private func makeNavigationLink<T: VoiceQuizLevelSelector>(_ selector: T) -> some View {
        Button {
            viewModel.togglePresenting(selector, isPresenting: true)
        } label: {
            VStack(spacing: 5) {
                Text(T.Quiz.title)
                    .lineLimit(1)
                    .font(.title)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.init(uiColor: .label))
                    .frame(maxWidth: .infinity)
                    .aspectRatio(6, contentMode: .fit) // height = width / 6をキープ
                
                SquareGrid(T.previewQuiz.options) { option in
                    option.viewType.view()
                }
                .aspectRatio(1, contentMode: .fill)
            }
            .padding(16)
            .background {
                Color(uiColor: .tertiarySystemBackground)
            }
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 4)
        }
        .navigationDestination(
            isPresented: .init(
                get: {
                    viewModel.presentedSelectors[selector.id] ?? false
                },
                set: { isPresenting in
                    viewModel.togglePresenting(selector, isPresenting: isPresenting)
                }
            )
        ) {
            Factory.quizLevelSelectorView(selector)
        }
    }
}

struct SelectQuizView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuizView<SelectQuizViewFactoryDummy>()
    }
}
