//
//  AnyObservable.swift
//  Pharos
//
//  Created by Nayanda on 16/11/22.
//

import Foundation

// MARK: AnyObservable

public protocol AnyObservable: AnyObject {
    var isAncestor: Bool { get }
    var parent: AnyObservable? { get }
    var source: AnyObservable? { get }
    var isValid: Bool { get }
    func release()
    func typeErased() -> Observable<Any>
}

typealias InvokableObservable = AnyObservable & InvokeChainable

// MARK: AnyObservable + Extensions

extension AnyObservable {
    @inlinable public var ancestor: AnyObservable? {
        isAncestor ? self: parent?.ancestor
    }
    
    @inlinable public var source: AnyObservable? { ancestor }
    
    @inlinable public var isValid: Bool { ancestor != nil }
}
