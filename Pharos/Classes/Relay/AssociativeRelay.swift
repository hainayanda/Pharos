//
//  AssociativeRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 19/06/21.
//

import Foundation

open class AssociativeBearerRelay<Value>: BearerRelay<Value>, AssociativeRelay {
    
    public weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value, consumer: ((Changes<Value>) -> Void)?) {
        self.associatedObject = object
        super.init(currentValue: currentValue, consumer: consumer)
    }
    
    open override func relay(changes: Changes<Value>) -> Bool {
        super.relay(changes: changes)
    }
    
    open override func ignore(when ignoring: @escaping Ignorer) -> Self {
        super.ignore(when: ignoring) as? Self ?? self
    }
    
    @discardableResult
    open override func multipleSetDelayed(by interval: TimeInterval) -> Self {
        super.multipleSetDelayed(by: interval) as? Self ?? self
    }
    
    @discardableResult
    open override func observe(on dispatcher: DispatchQueue) -> Self {
        super.observe(on: dispatcher) as? Self ?? self
    }
    
    @discardableResult
    open override func syncWhenInSameThread() -> Self {
        super.syncWhenInSameThread() as? Self ?? self
    }
    
    open override func invokeRelay() {
        super.invokeRelay()
    }
    
    open override func removeAllNextRelays() {
        super.removeAllNextRelays()
    }
    
    @discardableResult
    open override func addNext<Relay: BaseRelay<Value>>(relay: Relay) -> Relay {
        super.addNext(relay: relay)
    }
    
    open override func discard() {
        super.discard()
    }
}

open class AssociativeValueRelay<Value>: ValueRelay<Value>, AssociativeRelay {
    
    public weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value) {
        self.associatedObject = object
        super.init(currentValue: currentValue)
    }
    
    open override func relay(changes: Changes<Value>) -> Bool {
        super.relay(changes: changes)
    }
    
    open override func ignore(when ignoring: @escaping Ignorer) -> Self {
        super.ignore(when: ignoring) as? Self ?? self
    }
    
    @discardableResult
    open override func multipleSetDelayed(by interval: TimeInterval) -> Self {
        super.multipleSetDelayed(by: interval) as? Self ?? self
    }
    
    @discardableResult
    open override func observe(on dispatcher: DispatchQueue) -> Self {
        super.observe(on: dispatcher) as? Self ?? self
    }
    
    @discardableResult
    open override func syncWhenInSameThread() -> Self {
        super.syncWhenInSameThread() as? Self ?? self
    }
    
    open override func invokeRelay() {
        super.invokeRelay()
    }
    
    open override func removeAllNextRelays() {
        super.removeAllNextRelays()
    }
    
    @discardableResult
    open override func addNext<Relay: BaseRelay<Value>>(relay: Relay) -> Relay {
        super.addNext(relay: relay)
    }
    
    open override func discard() {
        super.discard()
    }
}

open class AssociativeTwoWayRelay<Value>: TwoWayRelay<Value>, AssociativeRelay {
    
    public weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value) {
        self.associatedObject = object
        super.init(currentValue: currentValue)
    }
    
    open override func relay(changes: Changes<Value>) -> Bool {
        super.relay(changes: changes)
    }
    
    open override func ignore(when ignoring: @escaping Ignorer) -> Self {
        super.ignore(when: ignoring) as? Self ?? self
    }
    
    @discardableResult
    open override func multipleSetDelayed(by interval: TimeInterval) -> Self {
        super.multipleSetDelayed(by: interval) as? Self ?? self
    }
    
    @discardableResult
    open override func observe(on dispatcher: DispatchQueue) -> Self {
        super.observe(on: dispatcher) as? Self ?? self
    }
    
    @discardableResult
    open override func syncWhenInSameThread() -> Self {
        super.syncWhenInSameThread() as? Self ?? self
    }
    
    open override func invokeRelay() {
        super.invokeRelay()
    }
    
    open override func removeAllNextRelays() {
        super.removeAllNextRelays()
    }
    
    @discardableResult
    open override func addNext<Relay: BaseRelay<Value>>(relay: Relay) -> Relay {
        super.addNext(relay: relay)
    }
    
    open override func discard() {
        super.discard()
    }
}
