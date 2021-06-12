//
//  RelayCollection+UIStackView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIStackView: PopulatedRelays {
    public typealias BaseRelayObject = UIStackView
}

public extension RelayCollection where Object: UIStackView {
    
    // MARK: Two Way Relay
    
    var axis: TwoWayRelay<NSLayoutConstraint.Axis> {
        .relay(of: object, \.axis)
    }
    
    var distribution: TwoWayRelay<UIStackView.Distribution> {
        .relay(of: object, \.distribution)
    }
    
    var alignment: TwoWayRelay<UIStackView.Alignment> {
        .relay(of: object, \.alignment)
    }
    
    var spacing: TwoWayRelay<CGFloat> {
        .relay(of: object, \.spacing)
    }
    
    var isBaselineRelativeArrangement: TwoWayRelay<Bool> {
        .relay(of: object, \.isBaselineRelativeArrangement)
    }
    
    var isLayoutMarginsRelativeArrangement: TwoWayRelay<Bool> {
        .relay(of: object, \.isLayoutMarginsRelativeArrangement)
    }
    
    // MARK: Value Relay
    
    var arrangedSubviews: ValueRelay<[UIView]> {
        .relay(of: object, \.arrangedSubviews)
    }
    
}
#endif
