//
//  RelayProtocols.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public protocol TransportRelay: AnyObject {
    associatedtype Observed
    typealias Ignorer = (Changes<Observed>) -> Bool
    var currentValue: RelayValue<Observed> { get }
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
    @available(*, renamed: "nextRelay")
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
    typealias Ignorer = (Changes<Observed>) -> Bool
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

public enum RelayException {
    case always
    case exceptInvokedManually
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
    
    /// shortcut to addObserver().whenDidSet(then:)
    /// - Parameter consume: closure that will run when relay fire
    /// - Returns: relay of value observed
    func addDidSet(_ consume: @escaping (Changes<Observed>) -> Void) -> ValueRelay<Observed> {
        addObserver().whenDidSet(then: consume)
    }
}

public extension TransportRelay where Observed: AnyObject {
    func ignoreSameInstance(_ except: RelayException = .always) -> Self {
        ignore {
            switch except {
            case .always:
                return $0.isSameInstance
            case .exceptInvokedManually:
                return !$0.invokedManually && $0.isSameInstance
            }
        }
    }
}

public extension TransportRelay where Observed: Equatable {
    
    @discardableResult
    func relayUniqueValue(_ except: RelayException = .always, to observer: TwoWayRelay<Observed>) -> TwoWayRelay<Observed> {
        addObserver().ignoreSameValue(except).relayValue(to: observer)
    }
    
    @discardableResult
    func relayUniqueValue(_ except: RelayException = .always, to observer: BearerRelay<Observed>) -> BearerRelay<Observed> {
        addObserver().ignoreSameValue(except).relayValue(to: observer)
    }
    
    /// shortcut to addObserver().whenDidSet(then:)
    /// - Parameter consume: closure that will run when relay fire
    /// - Returns: relay of value observed
    func addDidUniqueSet(_ except: RelayException = .always, _ consume: @escaping (Changes<Observed>) -> Void) -> ValueRelay<Observed> {
        addObserver().whenDidUniqueSet(except, then: consume)
    }
    
    func ignoreSameValue(_ except: RelayException = .always) -> Self {
        ignore {
            switch except {
            case .always:
                return $0.isNotChanging
            case .exceptInvokedManually:
                return !$0.invokedManually && $0.isNotChanging
            }
        }
    }
}

extension ObservableRelay {
    
    @discardableResult
    func whenDidSet<Observer: AnyObject>(invoke observer: Observer, method: @escaping (Observer) -> Consumer) -> Self {
        whenDidSet { [weak observer] changes in
            guard let observer = observer else { return }
            method(observer)(changes)
        }
    }
}

extension ObservableRelay where Observed: Equatable {
    
    @discardableResult
    func whenDidUniqueSet<Observer: AnyObject>(_ except: RelayException = .always, invoke observer: Observer, method: @escaping (Observer) -> Consumer) -> Self {
        ignoreSameValue(except).whenDidSet(invoke: observer, method: method)
    }
    
    @discardableResult
    func whenDidUniqueSet(_ except: RelayException = .always, then consume: @escaping Consumer) -> Self {
        ignoreSameValue(except).whenDidSet(then: consume)
    }
}
