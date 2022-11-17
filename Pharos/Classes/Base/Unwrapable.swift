//
//  Unwrapable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 16/11/22.
//

import Foundation

// MARK: Unwrappable

public protocol Unwrapable {
    associatedtype Wrapped
    
    func unwrap() -> Wrapped?
}

// MARK: Optional + Unwrapable

extension Optional: Unwrapable {
    @inlinable public func unwrap() -> Wrapped? {
        self
    }
}

// MARK: Observable + Unwrappable AKA Optional

extension Observable where Output: Unwrapable {
    /// Ignore all nil from this Observable
    /// - Returns: New Observable that ignores nil
    @inlinable public func compacted() -> Observable<Output.Wrapped> {
        compactMapped { $0.unwrap() }
    }
}
