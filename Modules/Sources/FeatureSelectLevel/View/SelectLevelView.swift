//
//  SelectLevelView.swift
//  
//
//  Created by 若江照仁 on 2023/02/22.
//

import SwiftUI
import Core
import Components

public struct SelectLevelView<Factory: SelectLevelViewFactoryProtocol, ViewModel: SelectLevelViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @State var columnsCount: Int = 0
    
    public init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = .init(wrappedValue: viewModel())
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                Button {
                    viewModel.practiceModeTapped()
                } label: {
                    HStack {
                        Spacer()
                        Text(L10n.PreviewMode.title)
                            .font(.title2)
                            .foregroundColor(.primary)
                        Text(L10n.PreviewMode.description(ViewModel.Drill.Option.allCases.count))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .background { Color.init(uiColor: .tertiarySystemBackground)}
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.2), radius: 4)
                    .padding(16)
                }
                .navigationDestination(isPresented: $viewModel.isPresentingPracticeMode) {
                    Factory.practiceModeView(viewModel.generators.first!)
                }
                LazyVGrid(columns: .init(repeating: .init(spacing: 16), count: columnsCount)) {
                    ForEach(Array(viewModel.generators)) { generator in
                        SelectLevelViewCell(
                            generator: generator,
                            star1: viewModel.drillRecords[generator.id]?.star1,
                            star2: viewModel.drillRecords[generator.id]?.star2,
                            star3: viewModel.drillRecords[generator.id]?.star3,
                            time: viewModel.drillRecords[generator.id]?.time,
                            locked: viewModel.drillRecords[generator.id] == nil
                        ) { generator in
                            viewModel.selectGenerator(generator: generator)
                        }
                    }
                }
            }
        }
        .onChangeFrame { size in
            columnsCount = max(Int(size.width / 400), 1)
        }
        .navigationTitle(ViewModel.Drill.title)
        .background {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
        }
        .refreshable {
            do {
                try await viewModel.refresh()
            } catch {
                print(error)
            }
        }
        .fullScreenCover(
            item: Binding<DrillGenerator<ViewModel.Drill>?>(
                get: { viewModel.selectedGenerator },
                set: { viewModel.selectGenerator(generator: $0) }
            ), onDismiss: {
                Task {
                    try await viewModel.refresh()
                }
            }
        ) { generator in
            if let record = viewModel.drillRecords[generator.id] {
                Factory.drillView(
                    generator: generator,
                    lastRecord: record
                ) {
                    viewModel.dismissDrill()
                }
            } else {
                EmptyView()
            }
        }
    }
}

#if DEBUG
struct SelectLevelView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLevelView<SelectLevelViewFactoryDummy, SelectLevelViewModelDummy>(viewModel: .init())
    }
}
#endif
