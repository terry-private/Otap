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

public protocol SelectQuizViewFactoryProtocol {
    associatedtype ViewModel: SelectQuizViewModelProtocol
    @MainActor
    static func quizLevelSelectorView<T: VoiceQuizLevelSelector>(_ selector: T) -> AnyView
    static var viewModel: ViewModel { get }
}

public enum SelectQuizViewFactoryImpl: SelectQuizViewFactoryProtocol {
    public typealias ViewModel = SelectQuizViewModelImpl
    
    @MainActor
    public static func quizLevelSelectorView<T: VoiceQuizLevelSelector>(_ selector: T) -> AnyView {
        SelectLevelView<SelectLevelViewFactoryImpl<T>>(viewModel: .init()).toAnyView()
    }
    
    public static var viewModel: ViewModel {
        .init(selectors: [
            ColorQuizLevelSelector.basic1,
            FunnyAnimalQuizLevelSelector.basic1,
            CreatureQuizLevelSelector.advanced1
        ])
    }
}

public protocol SelectQuizViewModelProtocol: ObservableObject {
    var selectors: [any VoiceQuizLevelSelector] { get }
}

public final class SelectQuizViewModelImpl: ObservableObject, SelectQuizViewModelProtocol {
    public let selectors: [any VoiceQuizLevelSelector]
    public init(selectors: [any VoiceQuizLevelSelector]) {
        self.selectors = selectors
    }
}

public struct SelectQuizView<Factory: SelectQuizViewFactoryProtocol>: View {
    let cells: [AnyView]
    @StateObject var viewModel: Factory.ViewModel
    
    @MainActor
    public init() {
        let viewModel = Factory.viewModel
        _viewModel = .init(wrappedValue: viewModel)
        cells = viewModel.selectors.map {
            Self.navigationCell($0).toAnyView()
        }
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(cells.indices, id: \.self) { index in
                    cells[index]
                }
            }
            .padding(16)
        }
        .navigationTitle("クイズを選択")
        .background {
            Color(uiColor: .secondarySystemBackground).ignoresSafeArea()
        }
    }
    
    @MainActor // for ViewModel.init()
    static func navigationCell<T: VoiceQuizLevelSelector>(_ selector: T) -> some View {
        NavigationLink {
            Factory.quizLevelSelectorView(selector)
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
            .shadow(color: .black.opacity(0.2), radius: 4)
        }
    }
}

struct SelectQuizView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuizView<SelectQuizViewFactoryImpl>()
    }
}
