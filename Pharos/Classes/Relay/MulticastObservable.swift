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
    typealias CastConsumer = (Changes<RelayedState>, PharosContext) -> Void
    
    let castConsumer: CastConsumer
    
    init(retainer: ContextRetainer, castConsumer: @escaping CastConsumer) {
        self.castConsumer = castConsumer
        super.init(retainer: retainer)
    }
    
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            castConsumer(changes, context)
            relayGroup.relay(changes: changes, context: context)
        }
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: BiCastObservable

final class BiCastObservable<State1, State2>: Observable<(State1?, State2?)>, StateRelay {
    typealias RelayedState = State
    
    lazy var subcast1: SubCastObservable<State1> = .init(retainer: contextRetainer) { [weak self] changes, context  in
        guard let self = self else { return }
        let old = (changes.old, self.recentState?.1)
        let new = (changes.new, self.recentState?.1)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    lazy var subcast2: SubCastObservable<State2> = .init(retainer: contextRetainer) { [weak self] changes, context  in
        guard let self = self else { return }
        let old = (self.recentState?.0, changes.old)
        let new = (self.recentState?.0, changes.new)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    weak var source1: Observable<State1>?
    weak var source2: Observable<State2>?
    override var recentState: State? {
        (source1?.recentState, source2?.recentState)
    }
    
    init(source1: Observable<State1>, source2: Observable<State2>, retainer: ContextRetainer) {
        self.source1 = source1
        self.source2 = source2
        super.init(retainer: retainer.added(with: source1).added(with: source2))
        source1.relayGroup.addToGroup(WeakRelayRetainer<State1>(wrapped: subcast1))
        source2.relayGroup.addToGroup(WeakRelayRetainer<State2>(wrapped: subcast2))
    }
    
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            relayGroup.relay(changes: changes, context: context)
        }
    }
    
    override func retain(retainer: ContextRetainer) {
        source1?.retain(retainer: retainer)
        source2?.retain(retainer: retainer)
    }
    
    override func discard(child: AnyObject) {
        contextRetainer.discard(object: child)
        source1?.discard(child: child)
        source2?.discard(child: child)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: TriCastObservable

final class TriCastObservable<State1, State2, State3>: Observable<(State1?, State2?, State3?)>, StateRelay {
    typealias RelayedState = State
    
    lazy var subcast1: SubCastObservable<State1> = .init(retainer: contextRetainer) { [weak self] changes, context  in
        guard let self = self else { return }
        let old = (changes.old, self.recentState?.1, self.recentState?.2)
        let new = (changes.new, self.recentState?.1, self.recentState?.2)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    lazy var subcast2: SubCastObservable<State2> = .init(retainer: contextRetainer) { [weak self] changes, context  in
        guard let self = self else { return }
        let old = (self.recentState?.0, changes.old, self.recentState?.2)
        let new = (self.recentState?.0, changes.new, self.recentState?.2)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    lazy var subcast3: SubCastObservable<State3> = .init(retainer: contextRetainer) { [weak self] changes, context  in
        guard let self = self else { return }
        let old = (self.recentState?.0, self.recentState?.1, changes.old)
        let new = (self.recentState?.0, self.recentState?.1, changes.new)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    weak var source1: Observable<State1>?
    weak var source2: Observable<State2>?
    weak var source3: Observable<State3>?
    
    override var recentState: State? {
        (source1?.recentState, source2?.recentState, source3?.recentState)
    }
    
    init(source1: Observable<State1>, source2: Observable<State2>, source3: Observable<State3>, retainer: ContextRetainer) {
        self.source1 = source1
        self.source2 = source2
        self.source3 = source3
        super.init(retainer: retainer.added(with: source1).added(with: source2).added(with: source3))
        source1.relayGroup.addToGroup(WeakRelayRetainer<State1>(wrapped: subcast1))
        source2.relayGroup.addToGroup(WeakRelayRetainer<State2>(wrapped: subcast2))
        source3.relayGroup.addToGroup(WeakRelayRetainer<State3>(wrapped: subcast3))
    }
    
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            relayGroup.relay(changes: changes, context: context)
        }
    }
    
    override func retain(retainer: ContextRetainer) {
        source1?.retain(retainer: retainer)
        source2?.retain(retainer: retainer)
        source3?.retain(retainer: retainer)
    }
    
    override func discard(child: AnyObject) {
        contextRetainer.discard(object: child)
        source1?.discard(child: child)
        source2?.discard(child: child)
        source3?.discard(child: child)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}

// MARK: QuadCastObservable

final class QuadCastObservable<State1, State2, State3, State4>
: Observable<(State1?, State2?, State3?, State4?)>, StateRelay {
    typealias RelayedState = State
    
    lazy var subcast1: SubCastObservable<State1> = .init(retainer: contextRetainer) { [weak self] changes, context  in
        guard let self = self else { return }
        let old = (changes.old, self.recentState?.1, self.recentState?.2, self.recentState?.3)
        let new = (changes.new, self.recentState?.1, self.recentState?.2, self.recentState?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    lazy var subcast2: SubCastObservable<State2> = .init(retainer: contextRetainer) { [weak self] changes, context  in
        guard let self = self else { return }
        let old = (self.recentState?.0, changes.old, self.recentState?.2, self.recentState?.3)
        let new = (self.recentState?.0, changes.new, self.recentState?.2, self.recentState?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    lazy var subcast3: SubCastObservable<State3> = .init(retainer: contextRetainer) { [weak self] changes, context in
        guard let self = self else { return }
        let old = (self.recentState?.0, self.recentState?.1, changes.old, self.recentState?.3)
        let new = (self.recentState?.0, self.recentState?.1, changes.new, self.recentState?.3)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
        )
    }
    
    lazy var subcast4: SubCastObservable<State4> = .init(retainer: contextRetainer) { [weak self] changes, context in
        guard let self = self else { return }
        let old = (self.recentState?.0, self.recentState?.1, self.recentState?.2, changes.old)
        let new = (self.recentState?.0, self.recentState?.1, self.recentState?.2, changes.new)
        self.relay(
            changes: Changes(
                old: old,
                new: new,
                source: changes.source
            ), context: context
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
         source3: Observable<State3>, source4: Observable<State4>, retainer: ContextRetainer) {
        self.source1 = source1
        self.source2 = source2
        self.source3 = source3
        self.source4 = source4
        super.init(
            retainer: retainer
                .added(with: source1)
                .added(with: source2)
                .added(with: source3)
                .added(with: source4)
        )
        source1.relayGroup.addToGroup(WeakRelayRetainer<State1>(wrapped: subcast1))
        source2.relayGroup.addToGroup(WeakRelayRetainer<State2>(wrapped: subcast2))
        source3.relayGroup.addToGroup(WeakRelayRetainer<State3>(wrapped: subcast3))
        source4.relayGroup.addToGroup(WeakRelayRetainer<State4>(wrapped: subcast4))
    }
    
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            relayGroup.relay(changes: changes, context: context)
        }
    }
    
    override func retain(retainer: ContextRetainer) {
        source1?.retain(retainer: retainer)
        source2?.retain(retainer: retainer)
        source3?.retain(retainer: retainer)
        source4?.retain(retainer: retainer)
    }
    
    override func discard(child: AnyObject) {
        contextRetainer.discard(object: child)
        source1?.discard(child: child)
        source2?.discard(child: child)
        source3?.discard(child: child)
        source4?.discard(child: child)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
