//
//  Task+.swift
//  
//
//  Created by 若江照仁 on 2023/02/17.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        try await sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}
