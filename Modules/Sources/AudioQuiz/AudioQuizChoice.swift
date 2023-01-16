//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import SwiftUI

public protocol AudioQuizChoice: Hashable {
    var foregroundColor: Color { get }
    var call: String { get }
    var imageName: String? { get }
}

public enum AudioQuizChoiceState {
    case unanswered
    case unselected
    case correct
    case wrong
}
