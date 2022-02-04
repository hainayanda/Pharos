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
    
    override func relay(changes: Changes<State>) {
        callRelayIfNeeded(for: changes)
        callCallbackIfNeeded(for: changes)
    }
    
    override func relay(changes: Changes<State>, skip: AnyStateRelay) {
        callRelayIfNeeded(for: changes, skip: skip)
        callCallbackIfNeeded(for: changes)
    }
    
    func callRelayIfNeeded(for changes: Changes<State>, skip: AnyStateRelay? = nil) {
        guard let skip = skip else {
            super.relay(changes: changes)
            return
        }
        super.relay(changes: changes, skip: skip)
    }
    
    func callCallbackIfNeeded(for changes: Changes<State>) {
        callBack(changes)
    }
}
