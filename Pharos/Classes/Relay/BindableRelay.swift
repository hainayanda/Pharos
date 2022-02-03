//
//  CallBackRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class BindableRelay<Observed>: RootObservableRelay<Observed> {
    
    typealias Relayed = Observed
    typealias CallBack = (Changes<Observed>) -> Void
    
    var callBack: CallBack
    
    init(callBack: @escaping CallBack = { _ in }) {
        self.callBack = callBack
    }
    
    open func bind(with relay: BindableRelay<Observed>) -> ObservedRelay<Observed> {
        relayChanges(to: relay)
            .retained(by: temporaryRetainer)
        return relay.relayChanges(to: self)
    }
    
    open override func relay(changes: Changes<Observed>) {
        callRelayIfNeeded(for: changes)
        callCallbackIfNeeded(for: changes)
    }
    
    override func relay(changes: Changes<Observed>, skip: AnyRelay) {
        callRelayIfNeeded(for: changes, skip: skip)
        callCallbackIfNeeded(for: changes)
    }
    
    func callRelayIfNeeded(for changes: Changes<Observed>, skip: AnyRelay? = nil) {
        guard let skip = skip else {
            super.relay(changes: changes)
            return
        }
        super.relay(changes: changes, skip: skip)
    }
    
    func callCallbackIfNeeded(for changes: Changes<Observed>) {
        callBack(changes)
    }
}
