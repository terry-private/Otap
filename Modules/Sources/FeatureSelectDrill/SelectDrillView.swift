//
//  SelectDrillView.swift
//  
//
//  Created by 若江照仁 on 2023/02/26.
//

import SwiftUI
import Core
import Components

public struct SelectDrillView<Factory: SelectDrillViewFactoryProtocol, ViewModel: SelectDrillViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    @State var columnsCount: Int = 0
    
    public init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
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
            columnsCount = max(Int(size.width / 250), 2)
        }
        .navigationTitle(L10n.navigationTitle)
        .background {
            Color(uiColor: .secondarySystemBackground).ignoresSafeArea()
        }
    }
    
    @MainActor
    private func navigationCell(_ selector: any DrillLevelSelector) -> some View {
        makeNavigationLink(selector).toAnyView()
    }
    
    @MainActor // for ViewModel.init()
    private func makeNavigationLink<T: DrillLevelSelector>(_ selector: T) -> some View {
        Button {
            viewModel.togglePresenting(selector, isPresenting: true)
        } label: {
            VStack(spacing: 5) {
                Text(T.Drill.title)
                    .lineLimit(1)
                    .font(.title)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.init(uiColor: .label))
                    .frame(maxWidth: .infinity)
                    .aspectRatio(6, contentMode: .fit) // height = width / 6をキープ
                
                SquareGrid(T.previewDrill.options) { option in
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
            Factory.DrillLevelSelectorView(selector)
        }
    }
}

#if DEBUG
struct SelectDrillView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDrillView<SelectDrillViewFactoryDummy, SelectDrillViewModelImpl>(viewModel: .init(selectors: [DrillLevelSelectorDummy.level1]))
    }
}
#endif
