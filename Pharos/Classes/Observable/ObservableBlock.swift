//
//  ObservableBlock.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

open class ObservableBlock<Output>: BufferedObservable<Output> {
    
    public typealias Acceptor = (Output) -> Void
    
    public init(_ block: @escaping (Acceptor) -> Void) {
        super.init()
        block { [weak self] output in
            guard let self = self else { return }
            self.accept(Changes(new: output, old: self.buffer))
            self.buffer = output
        }
    }
    
    @inlinable open override func observeChange(_ observer: @escaping Observable<Output>.Observer) -> Retainable {
        let retainable = super.observeChange(observer)
        guard let buffer = buffer else { return retainable }
        observer(Changes(new: buffer))
        return retainable
    }
}
