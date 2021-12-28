//
//  RelayProtocols.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public protocol TransportRelay: AnyObject {
    associatedtype Observed
    var currentValue: RelayValue<Observed> { get }
    @discardableResult
    func multipleSetDelayed(by interval: TimeInterval) -> Self
    @discardableResult
    func observe(on dispatcher: DispatchQueue) -> Self
    @discardableResult
    func syncWhenInSameThread() -> Self
    @discardableResult
    func retained(by retainer: Retainer) -> Self
    @discardableResult
    func addDidSet(_ consume: @escaping (Changes<Observed>) -> Void) -> ValueRelay<Observed>
    @discardableResult
    func addObserver() -> ValueRelay<Observed>
    @discardableResult
    func add<Relay: BaseRelay<Observed>>(observer: Relay) -> Relay
    @discardableResult
    func relayValue(to observer: TwoWayRelay<Observed>) -> TwoWayRelay<Observed>
    @discardableResult
    func relayValue(to observer: BearerRelay<Observed>) -> BearerRelay<Observed>
}

protocol ObservableRelay: TransportRelay {
    associatedtype Observed
    typealias Consumer = (Changes<Observed>) -> Void
    @discardableResult
    func whenDidSet(then consume: @escaping Consumer) -> Self
}

public protocol CallBackRelay {
    associatedtype ValueBack
    typealias BackConsumer = (Changes<ValueBack>) -> Void
    @discardableResult
    func relayBack(changes: Changes<ValueBack>) -> Bool
    func relayBackConsumer(_ consumer: @escaping BackConsumer)
}

public protocol AssociativeRelay: AnyObject {
    var associatedObject: AnyObject? { get }
    func retainToSource() -> Self
}

public protocol StateObservable {
    func invokeRelayWithCurrent()
    func removeAllRelay()
    func removeBond()
}

public extension AssociativeRelay {
    func retainToSource() -> Self {
        guard let object = associatedObject else { return self }
        objc_setAssociatedObject(
            object,
            String(ObjectIdentifier(self).hashValue)
                + String(ObjectIdentifier(object).hashValue),
            self,
            .OBJC_ASSOCIATION_RETAIN
        )
        return self
    }
}

public extension TransportRelay {
    
    func addObserver() -> ValueRelay<Observed> {
        add(observer: ValueRelay<Observed>(currentValue: currentValue))
    }
    
    @discardableResult
    func relayValue(to observer: TwoWayRelay<Observed>) -> TwoWayRelay<Observed> {
        add(observer: ClosureRelay { [weak observer] changes in
            observer?.relayBack(changes: changes)
        })
        return observer
    }
    
    @discardableResult
    func relayValue(to observer: BearerRelay<Observed>) -> BearerRelay<Observed> {
        add(observer: observer)
    }
    
    @discardableResult
    func addDidSet(_ consume: @escaping (Changes<Observed>) -> Void) -> ValueRelay<Observed> {
        addObserver().whenDidSet(then: consume)
    }
}
