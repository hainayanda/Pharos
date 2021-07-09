//
//  RelayCollection+UILabel.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UILabel {
    
    // MARK: Two Way Relay
    
    var text: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.text)
    }

    var font: AssociativeTwoWayRelay<UIFont?> {
        .relay(of: underlyingObject, \.font)
    }

    var textColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.textColor)
    }

    var shadowColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.shadowColor)
    }

    var shadowOffset: AssociativeTwoWayRelay<CGSize> {
        .relay(of: underlyingObject, \.shadowOffset)
    }
    
    var attributedText: AssociativeTwoWayRelay<NSAttributedString?> {
        .relay(of: underlyingObject, \.attributedText)
    }
    
    var highlightedTextColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.highlightedTextColor)
    }

    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isHighlighted)
    }

    var isUserInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isUserInteractionEnabled)
    }

    var isEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isEnabled)
    }
    
    var numberOfLines: AssociativeTwoWayRelay<Int> {
        .relay(of: underlyingObject, \.numberOfLines)
    }
    
    var adjustsFontSizeToFitWidth: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.adjustsFontSizeToFitWidth)
    }
    
    var minimumScaleFactor: TwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.minimumScaleFactor)
    }
    
    var allowsDefaultTighteningForTruncation: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.allowsDefaultTighteningForTruncation)
    }
    
    var preferredMaxLayoutWidth: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.preferredMaxLayoutWidth)
    }
    
}
#endif
