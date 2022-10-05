//
//  ObservableBlock.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

class ObservableBlock<Output>: Observable<Output> {
    
    typealias Acceptor = (Output) -> Void
    
    private var _recentState: Output?
    override var recentState: Output? { _recentState }
    
    init(_ block: @escaping (Acceptor) -> Void) {
        super.init()
        block({ [weak self] output in
            guard let self = self else { return }
            self.send(changes: Changes(new: output, old: self.recentState))
            self._recentState = output
        })
    }
}
