//
//  MulticastRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public extension TransportRelay {
    func merge<Relay: TransportRelay>(with relay: Relay) -> ValueRelay<(Observed, Relay.Observed)> {
        let biCastRelay: BiCastRelay<Observed, Relay.Observed> = .init(currentValue, relay.currentValue)
        add(observer: ClosureRelay {
            biCastRelay.relay(changes: $0)
        })
        relay.add(observer: ClosureRelay {
            biCastRelay.relay(changes: $0)
        })
        return biCastRelay
    }
    
    func merge<R2: TransportRelay, R3: TransportRelay>(with relay2: R2, _ relay3: R3)
    -> ValueRelay<(Observed, R2.Observed, R3.Observed)> {
        let triCastRelay: TriCastRelay<Observed, R2.Observed, R3.Observed> = .init(
            currentValue, relay2.currentValue, relay3.currentValue
        )
        add(observer: ClosureRelay {
            triCastRelay.relay(changes: $0)
        })
        relay2.add(observer: ClosureRelay {
            triCastRelay.relay(changes: $0)
        })
        relay3.add(observer: ClosureRelay {
            triCastRelay.relay(changes: $0)
        })
        return triCastRelay
    }
    
    func merge<R2: TransportRelay, R3: TransportRelay, R4: TransportRelay>(
        with relay2: R2, _ relay3: R3, _ relay4: R4)
    -> ValueRelay<(Observed, R2.Observed, R3.Observed, R4.Observed)> {
        let quadCastRelay: QuadCastRelay<Observed, R2.Observed, R3.Observed, R4.Observed> = .init(
            currentValue, relay2.currentValue, relay3.currentValue, relay4.currentValue
        )
        add(observer: ClosureRelay {
            quadCastRelay.relay(changes: $0)
        })
        relay2.add(observer: ClosureRelay {
            quadCastRelay.relay(changes: $0)
        })
        relay3.add(observer: ClosureRelay {
            quadCastRelay.relay(changes: $0)
        })
        relay4.add(observer: ClosureRelay {
            quadCastRelay.relay(changes: $0)
        })
        return quadCastRelay
    }
}

public func mergeRelays<R1: TransportRelay, R2: TransportRelay>(
    _ relay1: R1, _ relay2: R2) -> ValueRelay<(R1.Observed, R2.Observed)> {
    relay1.merge(with: relay2)
}

public func mergeRelays<R1: TransportRelay, R2: TransportRelay, R3: TransportRelay>(
    _ relay1: R1, _ relay2: R2, _ relay3: R3) -> ValueRelay<(R1.Observed, R2.Observed, R3.Observed)> {
    relay1.merge(with: relay2, relay3)
}

public func mergeRelays<R1: TransportRelay, R2: TransportRelay, R3: TransportRelay, R4: TransportRelay>(
    _ relay1: R1, _ relay2: R2, _ relay3: R3, _ relay4: R4) -> ValueRelay<(R1.Observed, R2.Observed, R3.Observed, R4.Observed)> {
    relay1.merge(with: relay2, relay3, relay4)
}

final class ClosureRelay<Value>: BaseRelay<Value> {
    
    typealias RelayAction = (Changes<Value>) -> Void
    
    var relayAction: RelayAction?
    var retained: Any?
    override var isValid: Bool {
        relayAction != nil
    }
    
    init(retained: Any? = nil, relayAction: @escaping RelayAction) {
        self.retained = retained
        self.relayAction = relayAction
    }
    
    @discardableResult
    override func relay(changes: Changes<Value>) -> Bool {
        relayAction?(changes)
        return true
    }
    
    override func discard() {
        relayAction = nil
        retained = nil
    }
    
    override func removeAllNextRelays() { }
}

final class BiCastRelay<V1, V2>: ValueRelay<(V1, V2)> {
    
    var currentValue1: RelayValue<V1>
    var currentValue2: RelayValue<V2>
    
    init(_ currentValue1: RelayValue<V1>, _ currentValue2: RelayValue<V2>) {
        self.currentValue1 = currentValue1
        self.currentValue2 = currentValue2
        super.init(currentValue: currentValue1.combine(with: currentValue2))
    }
    
    func relay(changes: Changes<V1>) {
        let source = changes.source
        let oldValue = changes.old.combine(with: currentValue2)
        currentValue1 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func relay(changes: Changes<V2>) {
        let source = changes.source
        let oldValue = currentValue1.combine(with: changes.old)
        currentValue2 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func tryToRelay(with oldValue: RelayValue<(V1, V2)>, source: Any) {
        let combined = currentValue1.combine(with: currentValue2)
        switch combined {
        case .value(let value):
            relay(changes: .init(old: oldValue, new: value, source: source))
        default:
            currentValue = combined
        }
    }
}

final class TriCastRelay<V1, V2, V3>: ValueRelay<(V1, V2, V3)> {
    
    var currentValue1: RelayValue<V1>
    var currentValue2: RelayValue<V2>
    var currentValue3: RelayValue<V3>
    
    init(_ currentValue1: RelayValue<V1>, _ currentValue2: RelayValue<V2>, _ currentValue3: RelayValue<V3>) {
        self.currentValue1 = currentValue1
        self.currentValue2 = currentValue2
        self.currentValue3 = currentValue3
        super.init(currentValue: currentValue1.combine(with: currentValue2, currentValue3))
    }
    
    func relay(changes: Changes<V1>) {
        let source = changes.source
        let oldValue = changes.old.combine(with: currentValue2, currentValue3)
        currentValue1 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func relay(changes: Changes<V2>) {
        let source = changes.source
        let oldValue = currentValue1.combine(with: changes.old, currentValue3)
        currentValue2 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func relay(changes: Changes<V3>) {
        let source = changes.source
        let oldValue = currentValue1.combine(with: currentValue2, changes.old)
        currentValue3 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func tryToRelay(with oldValue: RelayValue<(V1, V2, V3)>, source: Any) {
        let combined = currentValue1.combine(with: currentValue2, currentValue3)
        switch combined {
        case .value(let value):
            relay(changes: .init(old: oldValue, new: value, source: source))
        default:
            currentValue = combined
        }
    }
}

final class QuadCastRelay<V1, V2, V3, V4>: ValueRelay<(V1, V2, V3, V4)> {
    
    var currentValue1: RelayValue<V1>
    var currentValue2: RelayValue<V2>
    var currentValue3: RelayValue<V3>
    var currentValue4: RelayValue<V4>
    
    init(_ currentValue1: RelayValue<V1>, _ currentValue2: RelayValue<V2>, _ currentValue3: RelayValue<V3>, _ currentValue4: RelayValue<V4>) {
        self.currentValue1 = currentValue1
        self.currentValue2 = currentValue2
        self.currentValue3 = currentValue3
        self.currentValue4 = currentValue4
        super.init(currentValue: currentValue1.combine(with: currentValue2, currentValue3, currentValue4))
    }
    
    func relay(changes: Changes<V1>) {
        let source = changes.source
        let oldValue = changes.old.combine(with: currentValue2, currentValue3, currentValue4)
        currentValue1 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func relay(changes: Changes<V2>) {
        let source = changes.source
        let oldValue = currentValue1.combine(with: changes.old, currentValue3, currentValue4)
        currentValue2 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func relay(changes: Changes<V3>) {
        let source = changes.source
        let oldValue = currentValue1.combine(with: currentValue2, changes.old, currentValue4)
        currentValue3 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func relay(changes: Changes<V4>) {
        let source = changes.source
        let oldValue = currentValue1.combine(with: currentValue2, currentValue3, changes.old)
        currentValue4 = .value(changes.new)
        tryToRelay(with: oldValue, source: source)
    }
    
    func tryToRelay(with oldValue: RelayValue<(V1, V2, V3, V4)>, source: Any) {
        let combined = currentValue1.combine(with: currentValue2, currentValue3, currentValue4)
        switch combined {
        case .value(let value):
            relay(changes: .init(old: oldValue, new: value, source: source))
        default:
            currentValue = combined
        }
    }
}
