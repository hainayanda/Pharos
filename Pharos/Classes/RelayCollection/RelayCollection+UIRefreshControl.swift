//
//  RelayCollection+UIRefreshControl.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIRefreshControl: PopulatedRelays {
    public typealias BaseRelayObject = UIRefreshControl
}

public extension RelayCollection where Object: UIRefreshControl {
    
    // MARK: Two Way Relay
    
    var attributedTitle: TwoWayRelay<NSAttributedString?> {
        .relay(of: object, \.attributedTitle)
    }
    
    // MARK: Value Relay
    
    var isRefreshing: ValueRelay<Bool> {
        .relay(of: object, \.isRefreshing)
    }
    
    
}
#endif
