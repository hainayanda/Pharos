//
//  MulticastObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

// MARK: SubCastObservable

final class SubCastObservable<State>: Observable<State>, StateRelay {
    
    typealias RelayedState = State
    typealias CastConsumer = (Changes<RelayedState>) -> Void
    
    let castConsumer: CastConsumer
    
    init(castConsumer: @escaping CastConsumer) {
        self.castConsumer = castConsumer
    }
    
    func relay(changes: Changes<RelayedState>) {
        castConsumer(changes)
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<State>, skip: AnyStateRelay) {
        castConsumer(changes)
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: BiCastObservable

final class BiCastObservable<State1, State2>: Observable<(State1?, State2?)>, StateRelay {
    typealias RelayedState = State
    
    lazy var subcast1: SubCastObservable<State1> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (changes.old, self.recentState?.1)
        let new = (changes.new, self.recentState?.1)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast2: SubCastObservable<State2> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentState?.0, changes.old)
        let new = (self.recentState?.0, changes.new)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    weak var source1: Observable<State1>?
    weak var source2: Observable<State2>?
    override var recentState: State? {
        (source1?.recentState, source2?.recentState)
    }
    
    init(source1: Observable<State1>, source2: Observable<State2>) {
        self.source1 = source1
        self.source2 = source2
        super.init()
    }
    
    func relay(changes: Changes<RelayedState>) {
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<RelayedState>, skip: AnyStateRelay) {
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child: StateRelay>(relay: Child) where RelayedState == Child.RelayedState {
        super.retain(relay: relay)
        source1?.relayGroup.addToGroup(subcast1)
        source2?.relayGroup.addToGroup(subcast2)
    }
    
    override func retainWeakly<Child: StateRelay>(relay: Child, managedBy retainer: ObjectRetainer) where RelayedState == Child.RelayedState {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source1?.temporaryRetainer.discard(self)
        source2?.temporaryRetainer.discard(self)
        source1?.relayGroup.addToGroup(WeakRelayRetainer<State1>(wrapped: subcast1))
        source2?.relayGroup.addToGroup(WeakRelayRetainer<State2>(wrapped: subcast2))
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: TriCastObservable

final class TriCastObservable<State1, State2, State3>: Observable<(State1?, State2?, State3?)>, StateRelay {
    typealias RelayedState = State
    
    var subcast1: SubCastObservable<State1> {
        .init { [weak self] changes in
            guard let self = self else { return }
            let old = (changes.old, self.recentState?.1, self.recentState?.2)
            let new = (changes.new, self.recentState?.1, self.recentState?.2)
            self.relay(
                changes: Changes(
                    old: old,
                    new: new,
                    source: changes.source
                )
            )
        }
    }
    
    var subcast2: SubCastObservable<State2> {
        .init { [weak self] changes in
            guard let self = self else { return }
            let old = (self.recentState?.0, changes.old, self.recentState?.2)
            let new = (self.recentState?.0, changes.new, self.recentState?.2)
            self.relay(
                changes: Changes(
                    old: old,
                    new: new,
                    source: changes.source
                )
            )
        }
    }
    
    var subcast3: SubCastObservable<State3> {
        .init { [weak self] changes in
            guard let self = self else { return }
            let old = (self.recentState?.0, self.recentState?.1, changes.old)
            let new = (self.recentState?.0, self.recentState?.1, changes.new)
            self.relay(
                changes: Changes(
                    old: old,
                    new: new,
                    source: changes.source
                )
            )
        }
    }
    
    weak var source1: Observable<State1>?
    weak var source2: Observable<State2>?
    weak var source3: Observable<State3>?
    
    override var recentState: State? {
        (source1?.recentState, source2?.recentState, source3?.recentState)
    }
    
    init(source1: Observable<State1>, source2: Observable<State2>, source3: Observable<State3>) {
        self.source1 = source1
        self.source2 = source2
        self.source3 = source3
        super.init()
    }
    
    func relay(changes: Changes<RelayedState>) {
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<RelayedState>, skip: AnyStateRelay) {
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child: StateRelay>(relay: Child) where RelayedState == Child.RelayedState {
        super.retain(relay: relay)
        source1?.relayGroup.addToGroup(subcast1)
        source2?.relayGroup.addToGroup(subcast2)
        source3?.relayGroup.addToGroup(subcast3)
    }
    
    override func retainWeakly<Child: StateRelay>(relay: Child, managedBy retainer: ObjectRetainer) where RelayedState == Child.RelayedState {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source1?.temporaryRetainer.discard(self)
        source2?.temporaryRetainer.discard(self)
        source3?.temporaryRetainer.discard(self)
        source1?.relayGroup.addToGroup(WeakRelayRetainer<State1>(wrapped: subcast1))
        source2?.relayGroup.addToGroup(WeakRelayRetainer<State2>(wrapped: subcast2))
        source3?.relayGroup.addToGroup(WeakRelayRetainer<State3>(wrapped: subcast3))
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: QuadCastObservable

final class QuadCastObservable<State1, State2, State3, State4>
: Observable<(State1?, State2?, State3?, State4?)>, StateRelay {
    typealias RelayedState = State
    
    lazy var subcast1: SubCastObservable<State1> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (changes.old, self.recentState?.1, self.recentState?.2, self.recentState?.3)
        let new = (changes.new, self.recentState?.1, self.recentState?.2, self.recentState?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast2: SubCastObservable<State2> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentState?.0, changes.old, self.recentState?.2, self.recentState?.3)
        let new = (self.recentState?.0, changes.new, self.recentState?.2, self.recentState?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast3: SubCastObservable<State3> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentState?.0, self.recentState?.1, changes.old, self.recentState?.3)
        let new = (self.recentState?.0, self.recentState?.1, changes.new, self.recentState?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    lazy var subcast4: SubCastObservable<State4> = .init { [weak self] changes in
        guard let self = self else { return }
        let old = (self.recentState?.0, self.recentState?.1, self.recentState?.2, changes.old)
        let new = (self.recentState?.0, self.recentState?.1, self.recentState?.2, changes.new)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            )
        )
    }
    
    weak var source1: Observable<State1>?
    weak var source2: Observable<State2>?
    weak var source3: Observable<State3>?
    weak var source4: Observable<State4>?
    
    override var recentState: State? {
        (source1?.recentState, source2?.recentState, source3?.recentState, source4?.recentState)
    }
    
    init(source1: Observable<State1>, source2: Observable<State2>,
         source3: Observable<State3>, source4: Observable<State4>) {
        self.source1 = source1
        self.source2 = source2
        self.source3 = source3
        self.source4 = source4
        super.init()
    }
    
    func relay(changes: Changes<RelayedState>) {
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<RelayedState>, skip: AnyStateRelay) {
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child: StateRelay>(relay: Child) where RelayedState == Child.RelayedState {
        super.retain(relay: relay)
        source1?.relayGroup.addToGroup(subcast1)
        source2?.relayGroup.addToGroup(subcast2)
        source3?.relayGroup.addToGroup(subcast3)
        source4?.relayGroup.addToGroup(subcast4)
    }
    
    override func retainWeakly<Child: StateRelay>(relay: Child, managedBy retainer: ObjectRetainer) where RelayedState == Child.RelayedState {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source1?.temporaryRetainer.discard(self)
        source2?.temporaryRetainer.discard(self)
        source3?.temporaryRetainer.discard(self)
        source4?.temporaryRetainer.discard(self)
        source1?.relayGroup.addToGroup(WeakRelayRetainer<State1>(wrapped: subcast1))
        source2?.relayGroup.addToGroup(WeakRelayRetainer<State2>(wrapped: subcast2))
        source3?.relayGroup.addToGroup(WeakRelayRetainer<State3>(wrapped: subcast3))
        source4?.relayGroup.addToGroup(WeakRelayRetainer<State4>(wrapped: subcast4))
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
