//
//  SelectCategoryView.swift
//  
//
//  Created by 若江照仁 on 2023/02/22.
//

import SwiftUI
import Core
import Components
import UseCaseImpl
import RepositoryImpl

public final class SelectCategoryViewModel<Category: VoiceQuizCategory>: ObservableObject {
    @Published public var generators: [VoiceQuizGenerator<Category.Quiz>] = Category.allCases.map { $0.generator }
    @Published public var selectedGenerator: VoiceQuizGenerator<Category.Quiz>? = nil
}

public struct SelectCategoryView<Category: VoiceQuizCategory>: View {
    @StateObject var viewModel: SelectCategoryViewModel<Category> = .init()
    public init() {}
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(Array(viewModel.generators)) { generator in
                    Button {
                        viewModel.selectedGenerator = generator
                    } label: {
                        HStack{
                            SquareGrid(generator.quizzes().first!.options) { option in
                                option.foregroundColor
                            }
                            .frame(width: 140, height: 140)
                            VStack(alignment: .leading, spacing: 16) {
                                Text(generator.title)
                                    .font(.title)
                                    .foregroundColor(.init(uiColor: .label))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("条件: 60秒以内に10問正解")
                                    .font(.caption)
                                    .foregroundColor(.init(uiColor: .secondaryLabel))
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.yellow)
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.yellow)
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.yellow)
                                }
                            }
                            .overlay(alignment: .topTrailing) {
                                HStack(spacing: 8) {
                                    CrownImage()
                                        .frame(width: 16, height: 12)
                                    Text("44.12")
                                        .font(.caption)
                                    
                                }
                                .foregroundColor(.pink)
                            }
//                            .background { Color.red }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background {
                            Color(uiColor: .tertiarySystemBackground)
                        }
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .shadow(radius: 4)
                    }
                }
            }
        }
        .navigationTitle(Category.Quiz.title)
        .background {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
        }
        .sheet(item: $viewModel.selectedGenerator) { generator in
            VoiceQuizView(
                viewModel: VoiceQuizViewModelImpl<
                    Category.Quiz,
                    SoundEffectInteractor,
                    VoiceQuizInteractor<Category.Quiz, RepositoryImpl>
                >(
                    useCase: .init(
                        generator: generator,
                        lastRecord: .init(
                            star1: false,
                            star2: false,
                            star3: false
                        )
                    )
                )
            )
        }
    }
}

#if DEBUG
struct SelectCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCategoryView<VoiceQuizCategoryDummy>()
    }
}
#endif
