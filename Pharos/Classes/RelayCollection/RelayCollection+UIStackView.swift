//
//  RelayCollection+UIStackView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIStackView {
    
    // MARK: Two Way Relay
    
    var spacing: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.spacing)
    }
    
    var isBaselineRelativeArrangement: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isBaselineRelativeArrangement)
    }
    
    var isLayoutMarginsRelativeArrangement: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isLayoutMarginsRelativeArrangement)
    }
    
}
#endif
