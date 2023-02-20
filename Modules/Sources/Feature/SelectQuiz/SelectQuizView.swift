//
//  SelectQuizView.swift
//  
//
//  Created by 若江照仁 on 2023/01/21.
//

import SwiftUI
import Core
import Components

//public struct SelectQuizView: View {
//    enum SelectQuizType: CaseIterable {
//        case colorQuiz
//        
//        func quiz(by level: AudioQuizLevel) -> AudioQuizType {
//            switch self {
//            case .colorQuiz:
//                return .colorQuiz(ColorQuiz(by: level))
//            }
//        }
//        
//        private var type: any AudioQuiz.Type {
//            switch self {
//            case .colorQuiz:
//                return ColorQuiz.self as any AudioQuiz.Type
//            }
//        }
//        var title: String { type.title }
//    }
//    
//    struct Cell: View {
//        let selectQuizType: SelectQuizType
//        var body: some View {
//            HStack(spacing: 10) {
//                AudioQuizChoicesView(
//                    .init(width: 80, height: 80),
//                    selectedIndex: nil,
//                    quiz: selectQuizType.quiz(by: .level2).quiz,
//                    choiceTapped: {_ in },
//                    getState: { _ in .unanswered }
//                )
//                .allowsHitTesting(false)
//                
//                Text(selectQuizType.title)
//                    .foregroundColor(.init(uiColor: .label))
//                
//                Spacer()
//                
//                Image(systemName: "chevron.right")
//            }
//            .font(.system(size: 18))
//            .padding(30)
//            .frame(maxWidth: .infinity)
//            .background {
//                Color(uiColor: .tertiarySystemFill)
//                    .cornerRadius(8)
//                    .shadow(color: .black.opacity(0.2), radius: 8)
//            }
//        }
//    }
//    
//    @State var selectedQuizType: SelectQuizType? = nil
//    @State var audioTypes: [AudioQuizType] = []
//    
//    public init() {
//    }
//    
//    public var body: some View {
//        ZStack {
//            if selectedQuizType == nil {
//                ScrollView {
//                    VStack {
//                        LazyVStack {
//                            ForEach(SelectQuizType.allCases, id: \.self) { quizType in
//                                Cell(selectQuizType: quizType)
//                                    .onTapGesture {
//                                        withAnimation {
//                                            selectedQuizType = quizType
//                                        }
//                                    }
//                            }
//                            .padding(.horizontal, 16)
//                        }
//                        
//                    }
//                }
//                .transition(.move(edge: .leading))
//            } else {
//                ScrollView {
//                    VStack {
//                        LazyVStack(spacing: 10) {
//                            ForEach(AudioQuizLevel.allCases, id: \.self) { level in
//                                Button {
//                                    guard let selectedQuizType else { return }
//                                    Task { @MainActor in
//                                        audioTypes =  (0..<30).map { _ in selectedQuizType.quiz(by: level) }
//                                    }
//                                } label: {
//                                    Text(level.title)
//                                }
//                            }
//                            Button {
//                                guard let selectedQuizType else { return }
//                                Task { @MainActor in
//                                    audioTypes =  (0..<30).map { _ in selectedQuizType.quiz(by: .random) }
//                                }
//                            } label: {
//                                Text("ランダム")
//                            }
//                            .padding(.horizontal, 16)
//                        }
//                        
//                    }
//                }
//                .transition(.move(edge: .trailing))
//            }
//        }
//        .fullScreenCover(isPresented: .init(get: { audioTypes.count > 0 }, set: {_ in audioTypes = [] })) {
//            AudioQuizView(viewModel: AudioQuizViewModel<SoundEffectInteractor>(
//                quizzes: audioTypes))
//        }
//    }
//    
//}
//
//enum SelectQuizRoute {
//    case quiz(any SelectQuizUseCaseProtocol)
//    case level(any SelectQuizUseCaseProtocol)
//}
//
//final class SelectQuizRouter: ObservableObject {
//    @Published var path: [SelectQuizRoute] = []
//}

//public struct SelectQuizView: View {
////    @EnvironmentObject var router: SelectQuizRouter
//    struct Cell<Quiz: SoundQuiz>: View {
//        let quiz: Quiz
//        var body: some View {
//            HStack {
//                SquareGrid(quiz.options, spacing: 4) { option in
//                    Rectangle()
//                        .fill(option.foregroundColor.gradient)
//                }
//                .frame(width: 64, height: 64)
//                VStack {
//                    Text(Quiz.title)
//                        .font(.title3)
//                }
//                Spacer()
//                Image(systemName: "chevron.right")
//                    .padding(.trailing, 6)
//                    .foregroundColor(.gray)
//            }
//            .padding(10)
//            .background { Color(uiColor: .systemBackground)}
//            .cornerRadius(10)
//        }
//    }
//    
//    public var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVStack {
//                    Cell(quiz: ColorQuiz(options: [.red, .yellow, .blue, .green]))
//                }
//                .padding()
//            }
//            .background {
//                Color(uiColor: .secondarySystemBackground)
//                    .ignoresSafeArea()
//            }
//            .navigationTitle("ゲームを選択")
//        }
//    }
//}
//
//struct SelectQuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectQuizView()
//    }
//}
