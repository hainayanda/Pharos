//
//  ObservableProtocols.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public protocol ObservableRelay: class {
    associatedtype Observed
    typealias Consumer = (Changes<Observed>) -> Void
    typealias Ignorer = (Changes<Observed>) -> Bool
    var currentValue: Observed { get }
    @discardableResult
    func whenDidSet(then consume: @escaping Consumer) -> Self
    @discardableResult
    func ignore(when ignoring: @escaping Ignorer) -> Self
    @discardableResult
    func multipleSetDelayed(by interval: TimeInterval) -> Self
    @discardableResult
    func observe(on dispatcher: DispatchQueue) -> Self
    @discardableResult
    func syncWhenInSameThread() -> Self
    @discardableResult
    func referenceManaged(by dereferencer: Dereferencer) -> Self
    @discardableResult
    func nextRelay() -> ValueRelay<Observed>
    @discardableResult
    func relayNotification(to relay: BaseRelay<Observed>) -> Self
    @discardableResult
    func relayValue(to relay: TwoWayRelay<Observed>) -> TwoWayRelay<Observed>
    func invokeRelay()
}

public protocol CallBackRelay {
    associatedtype ValueBack
    typealias BackConsumer = (Changes<ValueBack>) -> Void
    @discardableResult
    func relayBack(changes: Changes<ValueBack>) -> Bool
    func relayBackConsumer(_ consumer: @escaping BackConsumer)
}

public protocol StateObservable {
    func invokeRelayWithCurrent()
    func removeAllRelay()
    func removeBond()
}

public extension ObservableRelay {
    @discardableResult
    func whenDidSet<Observer: AnyObject>(invoke observer: Observer, method: @escaping (Observer) -> Consumer) -> Self {
        whenDidSet { [weak observer] changes in
            guard let observer = observer else { return }
            method(observer)(changes)
        }
    }
    
    @discardableResult
    func relayValue(to relay: TwoWayRelay<Observed>) -> TwoWayRelay<Observed> {
        relayNotification(to: ClosureRelay { [weak relay] changes in
            relay?.relayBack(changes: changes)
        })
        return relay
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
    
    @discardableResult
    func relayUniqueValue(to relay: BondableRelay<Observed>) -> BondableRelay<Observed> {
        relayNotification(to: ClosureRelay { [weak relay] changes in
            guard changes.isChanging else { return }
            relay?.relayBack(changes: changes)
        })
        return relay
    }
    
    func ignoreSameValue() -> Self {
        ignore { $0.isNotChanging }
    }
}
