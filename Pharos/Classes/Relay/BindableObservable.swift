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
    
    public init(callBack: @escaping CallBack = { _ in }) {
        self.callBack = callBack
    }
    
    open func bind(with relay: BindableObservable<State>) -> Observed<State> {
        relayChanges(to: relay)
            .retained(by: temporaryRetainer)
        return relay.relayChanges(to: self)
    }
    
    override func relay(changes: Changes<State>, context: PharosContext) {
        superRelay(changes, context)
        callCallback(changes)
    }
    
    public override func relayChanges(to relay: BindableObservable<State>) -> Observed<State> {
        let observed = Observed(source: self) { [weak relay] changes, context in
            guard let relay = relay else { return }
            relay.relay(changes: changes, context: context)
        }
        temporaryRetainer.retain(observed)
        return observed
    }
    
    func superRelay(_ changes: Changes<State>, _ context: PharosContext) {
        super.relay(changes: changes, context: context)
    }
    
    func callCallback(_ changes: Changes<State>) {
        callBack(changes)
    }
}
