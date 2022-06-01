//
//  CallBackRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class BindableObservable<State>: RootObservable<State> {
    
    public typealias CallBack = (Changes<State>) -> Void
    typealias Relayed = State
    
    var callBack: CallBack
    
    public init(retainer: ContextRetainer, callBack: @escaping CallBack = { _ in }) {
        self.callBack = callBack
        super.init(retainer: retainer)
    }
    
    open func bind(with relay: BindableObservable<State>) -> Observed<State> {
        let theirRelay = relay.relayChanges(to: self)
        let myRelay = Observed(
            source: self,
            retainer: self.contextRetainer.added(with: theirRelay).added(with: self)
        ) {
            [weak relay] changes, context in
            guard let relay = relay else { return }
            relay.relay(changes: changes, context: context)
        }
        relayGroup.addToGroup(WeakRelayRetainer<State>(wrapped: myRelay))
        return myRelay
    }
    
    override func relay(changes: Changes<State>, context: PharosContext) {
        superRelay(changes, context)
        callCallback(changes)
    }
    
    public override func relayChanges(to relay: BindableObservable<State>) -> Observed<State> {
        let observed = Observed(source: self, retainer: self.contextRetainer.added(with: self)) { [weak relay] changes, context in
            guard let relay = relay else { return }
            relay.relay(changes: changes, context: context)
        }
        relayGroup.addToGroup(WeakRelayRetainer<State>(wrapped: observed))
        return observed
    }
    
    func superRelay(_ changes: Changes<State>, _ context: PharosContext) {
        super.relay(changes: changes, context: context)
    }
    
    func callCallback(_ changes: Changes<State>) {
        callBack(changes)
    }
}
