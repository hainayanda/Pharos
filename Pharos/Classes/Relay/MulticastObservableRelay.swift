//
//  MulticastObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

// MARK: SubCastObservableRelay

final class SubCastObservableRelay<Observed>: ObservableValue<Observed>, Relay {
    
    typealias Relayed = Observed
    typealias CastConsumer = (Changes<Relayed>) -> Void
    
    let castConsumer: CastConsumer
    
    init(castConsumer: @escaping CastConsumer) {
        self.castConsumer = castConsumer
    }
    
    func relay(changes: Changes<Relayed>) {
        castConsumer(changes)
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Observed>, skip: AnyRelay) {
        castConsumer(changes)
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: BiCastObservableRelay

final class BiCastObservableRelay<Observed1, Observed2>: ObservableValue<(Observed1?, Observed2?)>, Relay {
    typealias Relayed = Observed
    
    lazy var subcast1: SubCastObservableRelay<Observed1> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (changes.old, self.recentValue?.1)
        let new = (changes.new, self.recentValue?.1)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast2: SubCastObservableRelay<Observed2> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentValue?.0, changes.old)
        let new = (self.recentValue?.0, changes.new)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    weak var source1: ObservableValue<Observed1>?
    weak var source2: ObservableValue<Observed2>?
    override var recentValue: Observed? {
        (source1?.recentValue, source2?.recentValue)
    }
    
    init(source1: ObservableValue<Observed1>, source2: ObservableValue<Observed2>) {
        self.source1 = source1
        self.source2 = source2
        super.init()
    }
    
    func relay(changes: Changes<Relayed>) {
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyRelay) {
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child: Relay>(relay: Child) where Relayed == Child.Relayed {
        super.retain(relay: relay)
        source1?.relayGroup.addToGroup(subcast1)
        source2?.relayGroup.addToGroup(subcast2)
    }
    
    override func retainWeakly<Child: Relay>(relay: Child, managedBy retainer: Retainer) where Relayed == Child.Relayed {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source1?.temporaryRetainer.discard(self)
        source2?.temporaryRetainer.discard(self)
        source1?.relayGroup.addToGroup(WeakRelayRetainer<Observed1>(wrapped: subcast1))
        source2?.relayGroup.addToGroup(WeakRelayRetainer<Observed2>(wrapped: subcast2))
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: TriCastObservableRelay

final class TriCastObservableRelay<Observed1, Observed2, Observed3>: ObservableValue<(Observed1?, Observed2?, Observed3?)>, Relay {
    typealias Relayed = Observed
    
    var subcast1: SubCastObservableRelay<Observed1> {
        .init { [weak self] changes in
            guard let self = self else { return }
            let old = (changes.old, self.recentValue?.1, self.recentValue?.2)
            let new = (changes.new, self.recentValue?.1, self.recentValue?.2)
            self.relay(
                changes: Changes(
                    old: old,
                    new: new,
                    source: changes.source
                )
            )
        }
    }
    
    var subcast2: SubCastObservableRelay<Observed2> {
        .init { [weak self] changes in
            guard let self = self else { return }
            let old = (self.recentValue?.0, changes.old, self.recentValue?.2)
            let new = (self.recentValue?.0, changes.new, self.recentValue?.2)
            self.relay(
                changes: Changes(
                    old: old,
                    new: new,
                    source: changes.source
                )
            )
        }
    }
    
    var subcast3: SubCastObservableRelay<Observed3> {
        .init { [weak self] changes in
            guard let self = self else { return }
            let old = (self.recentValue?.0, self.recentValue?.1, changes.old)
            let new = (self.recentValue?.0, self.recentValue?.1, changes.new)
            self.relay(
                changes: Changes(
                    old: old,
                    new: new,
                    source: changes.source
                )
            )
        }
    }
    
    weak var source1: ObservableValue<Observed1>?
    weak var source2: ObservableValue<Observed2>?
    weak var source3: ObservableValue<Observed3>?
    
    override var recentValue: Observed? {
        (source1?.recentValue, source2?.recentValue, source3?.recentValue)
    }
    
    init(source1: ObservableValue<Observed1>, source2: ObservableValue<Observed2>, source3: ObservableValue<Observed3>) {
        self.source1 = source1
        self.source2 = source2
        self.source3 = source3
        super.init()
    }
    
    func relay(changes: Changes<Relayed>) {
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyRelay) {
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child: Relay>(relay: Child) where Relayed == Child.Relayed {
        super.retain(relay: relay)
        source1?.relayGroup.addToGroup(subcast1)
        source2?.relayGroup.addToGroup(subcast2)
        source3?.relayGroup.addToGroup(subcast3)
    }
    
    override func retainWeakly<Child: Relay>(relay: Child, managedBy retainer: Retainer) where Relayed == Child.Relayed {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source1?.temporaryRetainer.discard(self)
        source2?.temporaryRetainer.discard(self)
        source3?.temporaryRetainer.discard(self)
        source1?.relayGroup.addToGroup(WeakRelayRetainer<Observed1>(wrapped: subcast1))
        source2?.relayGroup.addToGroup(WeakRelayRetainer<Observed2>(wrapped: subcast2))
        source3?.relayGroup.addToGroup(WeakRelayRetainer<Observed2>(wrapped: subcast3))
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: QuadCastObservableRelay

final class QuadCastObservableRelay<Observed1, Observed2, Observed3, Observed4>
: ObservableValue<(Observed1?, Observed2?, Observed3?, Observed4?)>, Relay {
    typealias Relayed = Observed
    
    lazy var subcast1: SubCastObservableRelay<Observed1> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (changes.old, self.recentValue?.1, self.recentValue?.2, self.recentValue?.3)
        let new = (changes.new, self.recentValue?.1, self.recentValue?.2, self.recentValue?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast2: SubCastObservableRelay<Observed2> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentValue?.0, changes.old, self.recentValue?.2, self.recentValue?.3)
        let new = (self.recentValue?.0, changes.new, self.recentValue?.2, self.recentValue?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast3: SubCastObservableRelay<Observed3> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentValue?.0, self.recentValue?.1, changes.old, self.recentValue?.3)
        let new = (self.recentValue?.0, self.recentValue?.1, changes.new, self.recentValue?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast4: SubCastObservableRelay<Observed4> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentValue?.0, self.recentValue?.1, self.recentValue?.2, changes.old)
        let new = (self.recentValue?.0, self.recentValue?.1, self.recentValue?.2, changes.new)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    weak var source1: ObservableValue<Observed1>?
    weak var source2: ObservableValue<Observed2>?
    weak var source3: ObservableValue<Observed3>?
    weak var source4: ObservableValue<Observed4>?
    
    override var recentValue: Observed? {
        (source1?.recentValue, source2?.recentValue, source3?.recentValue, source4?.recentValue)
    }
    
    init(source1: ObservableValue<Observed1>, source2: ObservableValue<Observed2>,
         source3: ObservableValue<Observed3>, source4: ObservableValue<Observed4>) {
        self.source1 = source1
        self.source2 = source2
        self.source3 = source3
        self.source4 = source4
        super.init()
    }
    
    func relay(changes: Changes<Relayed>) {
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyRelay) {
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child: Relay>(relay: Child) where Relayed == Child.Relayed {
        super.retain(relay: relay)
        source1?.relayGroup.addToGroup(subcast1)
        source2?.relayGroup.addToGroup(subcast2)
        source3?.relayGroup.addToGroup(subcast3)
        source4?.relayGroup.addToGroup(subcast4)
    }
    
    override func retainWeakly<Child: Relay>(relay: Child, managedBy retainer: Retainer) where Relayed == Child.Relayed {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source1?.temporaryRetainer.discard(self)
        source2?.temporaryRetainer.discard(self)
        source3?.temporaryRetainer.discard(self)
        source4?.temporaryRetainer.discard(self)
        source1?.relayGroup.addToGroup(WeakRelayRetainer<Observed1>(wrapped: subcast1))
        source2?.relayGroup.addToGroup(WeakRelayRetainer<Observed2>(wrapped: subcast2))
        source3?.relayGroup.addToGroup(WeakRelayRetainer<Observed2>(wrapped: subcast3))
        source4?.relayGroup.addToGroup(WeakRelayRetainer<Observed2>(wrapped: subcast4))
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}
