//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import RepositoryImpl
import UseCaseImpl


public protocol VoiceQuizViewFactoryProtocol {
    associatedtype Quiz: VoiceQuiz
    associatedtype ViewModel: VoiceQuizViewModelProtocol<Quiz>
    var voiceQuizViewModel: ViewModel { get }
}
