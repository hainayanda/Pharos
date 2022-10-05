//
//  CombinedObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

class BiCombinedObservable<Output1, Output2>: Observable<(Output1?, Output2?)> {
    
    private weak var observable1: Observable<Output1>?
    private weak var observable2: Observable<Output2>?
    
    override var recentState: (Output1?, Output2?)? {
        (observable1?.recentState, observable2?.recentState)
    }
    
    init(observable1: Observable<Output1>, observable2: Observable<Output2>) {
        super.init()
        
        self.observable1 = observable1
        self.observable2 = observable2
        
        observable1.mapped { [weak self] state in
            let recentState = self?.recentState
            return (state, recentState?.1)
        }
        .relayChanges(to: self)
        .retain()
        observable2.mapped { [weak self] state in
            let recentState = self?.recentState
            return (recentState?.0, state)
        }
        .relayChanges(to: self)
        .retain()
        
        observable1.retain(self)
        observable2.retain(self)
    }
}

extension Observable {
    public func combine<Output2>(with other: Observable<Output2>) -> Observable<(Output?, Output2?)> {
        BiCombinedObservable(observable1: self, observable2: other)
    }
    
    public func compactCombine<Output2>(
        with other1: Observable<Output2>) -> Observable<(Output, Output2)> {
            combine(with: other1)
                .compactMapped {
                    guard let output1 = $0.0,
                          let output2 = $0.1 else {
                        return nil
                    }
                    return (output1, output2)
                }
        }
}

class TriCombinedObservable<Output1, Output2, Output3>: Observable<(Output1?, Output2?, Output3?)> {
    
    private weak var observable1: Observable<Output1>?
    private weak var observable2: Observable<Output2>?
    private weak var observable3: Observable<Output3>?
    
    override var recentState: (Output1?, Output2?, Output3?)? {
        (observable1?.recentState, observable2?.recentState, observable3?.recentState)
    }
    
    init(
        observable1: Observable<Output1>,
        observable2: Observable<Output2>,
        observable3: Observable<Output3>) {
            super.init()
            
            self.observable1 = observable1
            self.observable2 = observable2
            self.observable3 = observable3
            
            observable1.mapped { [weak self] state in
                let recentState = self?.recentState
                return (state, recentState?.1, recentState?.2)
            }
            .relayChanges(to: self)
            .retain()
            observable2.mapped { [weak self] state in
                let recentState = self?.recentState
                return (recentState?.0, state, recentState?.2)
            }
            .relayChanges(to: self)
            .retain()
            observable3.mapped { [weak self] state in
                let recentState = self?.recentState
                return (recentState?.0, recentState?.1, state)
            }
            .relayChanges(to: self)
            .retain()
            
            observable1.retain(self)
            observable2.retain(self)
            observable3.retain(self)
        }
}

extension Observable {
    public func combine<Output2, Output3>(
        with other1: Observable<Output2>,
        _ other2: Observable<Output3>) -> Observable<(Output?, Output2?, Output3?)> {
            TriCombinedObservable(observable1: self, observable2: other1, observable3: other2)
        }
    
    public func compactCombine<Output2, Output3>(
        with other1: Observable<Output2>,
        _ other2: Observable<Output3>) -> Observable<(Output, Output2, Output3)> {
            combine(with: other1, other2)
                .compactMapped {
                    guard let output1 = $0.0,
                          let output2 = $0.1,
                          let output3 = $0.2 else {
                        return nil
                    }
                    return (output1, output2, output3)
                }
        }
}

class QuadCombinedObservable<Output1, Output2, Output3, Output4>: Observable<(Output1?, Output2?, Output3?, Output4?)> {
    
    private weak var observable1: Observable<Output1>?
    private weak var observable2: Observable<Output2>?
    private weak var observable3: Observable<Output3>?
    private weak var observable4: Observable<Output4>?
    
    override var recentState: (Output1?, Output2?, Output3?, Output4?)? {
        (observable1?.recentState, observable2?.recentState, observable3?.recentState, observable4?.recentState)
    }
    
    init(
        observable1: Observable<Output1>,
        observable2: Observable<Output2>,
        observable3: Observable<Output3>,
        observable4: Observable<Output4>) {
            super.init()
            
            self.observable1 = observable1
            self.observable2 = observable2
            self.observable3 = observable3
            self.observable4 = observable4
            
            observable1.mapped { [weak self] state in
                let recentState = self?.recentState
                return (state, recentState?.1, recentState?.2, recentState?.3)
            }
            .relayChanges(to: self)
            .retain()
            observable2.mapped { [weak self] state in
                let recentState = self?.recentState
                return (recentState?.0, state, recentState?.2, recentState?.3)
            }
            .relayChanges(to: self)
            .retain()
            observable3.mapped { [weak self] state in
                let recentState = self?.recentState
                return (recentState?.0, recentState?.1, state, recentState?.3)
            }
            .relayChanges(to: self)
            .retain()
            observable4.mapped { [weak self] state in
                let recentState = self?.recentState
                return (recentState?.0, recentState?.1, recentState?.2, state)
            }
            .relayChanges(to: self)
            .retain()
            
            observable1.retain(self)
            observable2.retain(self)
            observable3.retain(self)
            observable4.retain(self)
        }
}

extension Observable {
    public func combine<Output2, Output3, Output4>(
        with other1: Observable<Output2>,
        _ other2: Observable<Output3>,
        _ other3: Observable<Output4>) -> Observable<(Output?, Output2?, Output3?, Output4?)> {
            QuadCombinedObservable(
                observable1: self,
                observable2: other1,
                observable3: other2,
                observable4: other3
            )
        }
    
    public func compactCombine<Output2, Output3, Output4>(
        with other1: Observable<Output2>,
        _ other2: Observable<Output3>,
        _ other3: Observable<Output4>) -> Observable<(Output, Output2, Output3, Output4)> {
            combine(with: other1, other2, other3)
                .compactMapped {
                    guard let output1 = $0.0,
                          let output2 = $0.1,
                          let output3 = $0.2,
                          let output4 = $0.3 else {
                        return nil
                    }
                    return (output1, output2, output3, output4)
                }
        }
}
