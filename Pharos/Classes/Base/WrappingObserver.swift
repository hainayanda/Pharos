//
//  WrappingObserver.swift
//  Pharos
//
//  Created by Nayanda Haberty on 24/11/22.
//

import Foundation

protocol WrappingObserver {
    var wrapped: AnyObject? { get }
}

extension WeakWrappedObserver: WrappingObserver {
    var wrapped: AnyObject? { observer?.wrapped ?? observer }
}

extension RetainableObserver: WrappingObserver {
    var wrapped: AnyObject? { (child as? WrappingObserver)?.wrapped ?? child }
}
