//
//  Subject.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@propertyWrapper
public final class Subject<Wrapped>: Observable<Wrapped> {
    
    @inlinable public var projectedValue: Observable<Wrapped> { self }
    
    private var _wrappedValue: Wrapped
    public var wrappedValue: Wrapped {
        get {
            _wrappedValue
        }
        set {
            sendIfNeeded(for: Changes(new: newValue, old: _wrappedValue))
        }
    }
    
    public override var recentState: Wrapped? { _wrappedValue }
    
    public init(wrappedValue: Wrapped) {
        _wrappedValue = wrappedValue
    }
    
    public override func fire() {
        send(changes: Changes(new: wrappedValue).consumed(by: self))
    }
    
    @discardableResult
    public override func sendIfNeeded(for changes: Changes<Wrapped>) -> Bool {
        guard super.sendIfNeeded(for: changes) else { return false }
        _wrappedValue = changes.new
        return true
    }
}
