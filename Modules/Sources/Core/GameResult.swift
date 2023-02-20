//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

import Foundation

public enum GameResult: Equatable {
    case success(Grades)
    case timeOver
    case gameOver
    
    public var hasFirst: Bool {
        guard case let .success(grades) = self else {
            return false
        }
        return grades.hasFirst
    }
}

public extension  GameResult {
    struct Grades: Equatable {
        public var star1: StarState
        public var star2: StarState
        public var star3: StarState
        
        var hasFirst: Bool {
            star1.isFirst || star2.isFirst || star3.isFirst
        }
        
        public init(star1: StarState, star2: StarState, star3: StarState) {
            self.star1 = star1
            self.star2 = star2
            self.star3 = star3
        }
    }
}

public extension  GameResult {
    enum StarState: Equatable {
        case unlocked(isFirst: Bool)
        case locked
        public init(before: Bool, after: Bool) {
            if before && after {
                self = .unlocked(isFirst: false)
            } else if after {
                self = .unlocked(isFirst: true)
            } else {
                self = .locked
            }
        }
        public var unlocked: Bool {
            if case .unlocked = self {
                return true
            } else {
                return false
            }
        }
        public var isFirst: Bool {
            switch self {
            case let .unlocked(isFirst):
                return isFirst
            default: return false
            }
        }
    }
}
