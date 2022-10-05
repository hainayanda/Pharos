//
//  ObservableBlock.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public final class ObservableBlock<Output>: Observable<Output> {
    
    public typealias Acceptor = (Output) -> Void
    
    private var _recentState: Output?
    public override var recentState: Output? { _recentState }
    
    public init(_ block: @escaping (Acceptor) -> Void) {
        super.init()
        block({ [weak self] output in
            guard let self = self else { return }
            self.send(changes: Changes(new: output, old: self.recentState))
            self._recentState = output
        })
    }
}
