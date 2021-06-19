//
//  RelayProtocols.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public protocol ObservableRelay: TransportRelay {
    associatedtype Observed
    typealias Consumer = (Changes<Observed>) -> Void
    typealias Ignorer = (Changes<Observed>) -> Bool
    @discardableResult
    func whenDidSet(then consume: @escaping Consumer) -> Self
}

public protocol TransportRelay: class {
    associatedtype Observed
    typealias Ignorer = (Changes<Observed>) -> Bool
    var currentValue: Observed { get }
    @discardableResult
    func ignore(when ignoring: @escaping Ignorer) -> Self
    @discardableResult
    func multipleSetDelayed(by interval: TimeInterval) -> Self
    @discardableResult
    func observe(on dispatcher: DispatchQueue) -> Self
    @discardableResult
    func syncWhenInSameThread() -> Self
    @discardableResult
    func retained(by retainer: Retainer) -> Self
    @discardableResult
    func nextRelay() -> ValueRelay<Observed>
    @discardableResult
    func addNext<Relay: BaseRelay<Observed>>(relay: Relay) -> Relay
    @discardableResult
    func relayValue(to relay: TwoWayRelay<Observed>) -> TwoWayRelay<Observed>
    @discardableResult
    func relayValue(to relay: BearerRelay<Observed>) -> BearerRelay<Observed>
}

public protocol CallBackRelay {
    associatedtype ValueBack
    typealias BackConsumer = (Changes<ValueBack>) -> Void
    @discardableResult
    func relayBack(changes: Changes<ValueBack>) -> Bool
    func relayBackConsumer(_ consumer: @escaping BackConsumer)
}

public protocol AssociativeRelay: class {
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
    
    func nextRelay() -> ValueRelay<Observed> {
        addNext(relay: ValueRelay<Observed>(currentValue: currentValue))
    }
    
    @discardableResult
    func relayValue(to relay: TwoWayRelay<Observed>) -> TwoWayRelay<Observed> {
        addNext(relay: ClosureRelay { [weak relay] changes in
            relay?.relayBack(changes: changes)
        })
        return relay
    }
    
    @discardableResult
    func relayValue(to relay: BearerRelay<Observed>) -> BearerRelay<Observed> {
        addNext(relay: relay)
    }
}

public extension TransportRelay where Observed: Equatable {
    
    @discardableResult
    func relayUniqueValue(to relay: TwoWayRelay<Observed>) -> TwoWayRelay<Observed> {
        nextRelay().ignoreSameValue().relayValue(to: relay)
    }
    
    @discardableResult
    func relayUniqueValue(to relay: BearerRelay<Observed>) -> BearerRelay<Observed> {
        nextRelay().ignoreSameValue().relayValue(to: relay)
    }
    
    func ignoreSameValue() -> Self {
        ignore { $0.isNotChanging }
    }
}

public extension ObservableRelay {
    
    @discardableResult
    func whenDidSet<Observer: AnyObject>(invoke observer: Observer, method: @escaping (Observer) -> Consumer) -> Self {
        whenDidSet { [weak observer] changes in
            guard let observer = observer else { return }
            method(observer)(changes)
        }
    }
}

public extension ObservableRelay where Observed: Equatable {
    
    @discardableResult
    func whenDidUniqueSet<Observer: AnyObject>(invoke observer: Observer, method: @escaping (Observer) -> Consumer) -> Self {
        whenDidUniqueSet { [weak observer] changes in
            guard let observer = observer else { return }
            method(observer)(changes)
        }
    }
    
    @discardableResult
    func whenDidUniqueSet(then consume: @escaping Consumer) -> Self {
        whenDidSet { changes in
            guard changes.isChanging else { return }
            consume(changes)
        }
    }
}
