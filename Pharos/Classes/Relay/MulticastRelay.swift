//
//  MulticastRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public extension TransportRelay {
    func merge<Relay: TransportRelay>(with relay: Relay) -> ValueRelay<(Observed, Relay.Observed)> {
        let biCastRelay: BiCastRelay<Observed, Relay.Observed> = .init(
            currentValue: (currentValue, relay.currentValue)
        )
        addNext(relay: ClosureRelay {
            biCastRelay.relay(changes: $0)
        })
        relay.addNext(relay: ClosureRelay {
            biCastRelay.relay(changes: $0)
        })
        return biCastRelay
    }
    
    func merge<R2: TransportRelay, R3: TransportRelay>(with relay2: R2, _ relay3: R3)
    -> ValueRelay<(Observed, R2.Observed, R3.Observed)> {
        let triCastRelay: TriCastRelay<Observed, R2.Observed, R3.Observed> = .init(
            currentValue: (currentValue, relay2.currentValue, relay3.currentValue)
        )
        addNext(relay: ClosureRelay {
            triCastRelay.relay(changes: $0)
        })
        relay2.addNext(relay: ClosureRelay {
            triCastRelay.relay(changes: $0)
        })
        relay3.addNext(relay: ClosureRelay {
            triCastRelay.relay(changes: $0)
        })
        return triCastRelay
    }
    
    func merge<R2: TransportRelay, R3: TransportRelay, R4: TransportRelay>(
        with relay2: R2, _ relay3: R3, _ relay4: R4)
    -> ValueRelay<(Observed, R2.Observed, R3.Observed, R4.Observed)> {
        let quadCastRelay: QuadCastRelay<Observed, R2.Observed, R3.Observed, R4.Observed> = .init(
            currentValue: (currentValue, relay2.currentValue, relay3.currentValue, relay4.currentValue)
        )
        addNext(relay: ClosureRelay {
            quadCastRelay.relay(changes: $0)
        })
        relay2.addNext(relay: ClosureRelay {
            quadCastRelay.relay(changes: $0)
        })
        relay3.addNext(relay: ClosureRelay {
            quadCastRelay.relay(changes: $0)
        })
        relay4.addNext(relay: ClosureRelay {
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
    
    func relay(changes: Changes<V1>) {
        let old: (V1, V2) = (changes.old, currentValue.1)
        let new = (changes.new, currentValue.1)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
    
    func relay(changes: Changes<V2>) {
        let old: (V1, V2) = (currentValue.0, changes.old)
        let new = (currentValue.0, changes.new)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
}

final class TriCastRelay<V1, V2, V3>: ValueRelay<(V1, V2, V3)> {
    
    func relay(changes: Changes<V1>) {
        let old: (V1, V2, V3) = (changes.old, currentValue.1, currentValue.2)
        let new = (changes.new, currentValue.1, currentValue.2)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
    
    func relay(changes: Changes<V2>) {
        let old: (V1, V2, V3) = (currentValue.0, changes.old, currentValue.2)
        let new = (currentValue.0, changes.new, currentValue.2)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
    
    func relay(changes: Changes<V3>) {
        let old: (V1, V2, V3) = (currentValue.0, currentValue.1, changes.old)
        let new = (currentValue.0, currentValue.1, changes.new)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
}

final class QuadCastRelay<V1, V2, V3, V4>: ValueRelay<(V1, V2, V3, V4)> {
    
    func relay(changes: Changes<V1>) {
        let old: (V1, V2, V3, V4) = (changes.old, currentValue.1, currentValue.2, currentValue.3)
        let new = (changes.new, currentValue.1, currentValue.2, currentValue.3)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
    
    func relay(changes: Changes<V2>) {
        let old: (V1, V2, V3, V4) = (currentValue.0, changes.old, currentValue.2, currentValue.3)
        let new = (currentValue.0, changes.new, currentValue.2, currentValue.3)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
    
    func relay(changes: Changes<V3>) {
        let old: (V1, V2, V3, V4) = (currentValue.0, currentValue.1, changes.old, currentValue.3)
        let new = (currentValue.0, currentValue.1, changes.new, currentValue.3)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
    
    func relay(changes: Changes<V4>) {
        let old: (V1, V2, V3, V4) = (currentValue.0, currentValue.1, currentValue.2, changes.old)
        let new = (currentValue.0, currentValue.1, currentValue.2, changes.new)
        relay(changes: .init(old: old, new: new, source: changes.source))
    }
}
