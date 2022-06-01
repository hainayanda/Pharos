//
//  ObservableBlock.swift
//  Pharos
//
//  Created by Nayanda Haberty on 01/06/22.
//

import Foundation

open class ObservableBlock<State>: Observable<State> {
    
    public typealias Completion = (State) -> Void
    private var _recentState: State?
    override var recentState: State? { _recentState }
    
    public init(_ block: @escaping (@escaping Completion) -> Void) {
        super.init(retainer: ContextRetainer())
        block { [weak self] result in
            guard let self = self else { return }
            self.relayGroup.relay(
                changes: Changes(old: self.recentState, new: result, source: self),
                context: PharosContext()
            )
            self._recentState = result
        }
    }
    
}
