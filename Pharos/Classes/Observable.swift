//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@propertyWrapper
public class Observable<Wrapped>: StateObservable {
    public typealias Getter = () -> Wrapped
    typealias OptionalGetter = () -> Wrapped?
    public typealias Setter = (Wrapped) -> Void
    var getter: OptionalGetter?
    var setter: Setter?
    lazy public internal(set) var relay: BondableRelay<Wrapped> = {
        let relay = BondableRelay<Wrapped>(currentValue: _wrappedValue)
        relay.relayBackConsumer { [weak self] changes in
            guard let self = self else { return }
            self.setAndInformToRelay(with: changes)
        }
        return relay
    }()
    var _wrappedValue: Wrapped
    public var wrappedValue: Wrapped {
        get {
            getter?() ?? _wrappedValue
        }
        set {
            setAndInformToRelay(with: Changes(old: _wrappedValue, new: newValue, source: self))
        }
    }
    
    public init(wrappedValue: Wrapped) {
        self._wrappedValue = wrappedValue
    }
    
    public init(get getter: @escaping Getter, set setter: @escaping Setter) {
        self._wrappedValue = getter()
        mutator(get: getter, set: setter)
    }
    
    public init<Object: AnyObject>(
        of object: Object,
        get getter: @escaping (Object) -> Getter,
        set setter: @escaping (Object) -> Setter) {
        self._wrappedValue = getter(object)()
        mutator(of: object, get: getter, set: setter)
    }
    
    public var projectedValue: BondableRelay<Wrapped> {
        relay
    }
    
    public func mutator(get getter: @escaping Getter, set setter: @escaping Setter) {
        self.getter = getter
        self.setter = setter
    }
    
    public func mutator<Object: AnyObject>(
        of object: Object,
        get getter: @escaping (Object) -> Getter,
        set setter: @escaping (Object) -> Setter) {
        self.getter = { [weak self, weak object] in
            guard let object = object else {
                return self?._wrappedValue
            }
            return getter(object)()
        }
        self.setter = { [weak object] value in
            guard let object = object else { return }
            setter(object)(value)
        }
    }
    
    public func invokeRelayWithCurrent() {
        informDidSetToRelay(with: .init(old: _wrappedValue, new: _wrappedValue, source: self))
    }
    
    public func removeBond() {
        relay.bondingRelay = nil
    }
    
    public func removeAllRelay() {
        relay.removeAllNextRelays()
    }
    
    func setAndInformToRelay(with changes: Changes<Wrapped>) {
        setter?(changes.new)
        _wrappedValue = changes.new
        informDidSetToRelay(with: changes)
    }
    
    func informDidSetToRelay(with changes: Changes<Wrapped>) {
        relay.relay(changes: changes)
    }
}
