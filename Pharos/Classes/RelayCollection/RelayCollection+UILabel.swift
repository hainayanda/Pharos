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
        .relay(of: object, \.text)
    }

    var font: AssociativeTwoWayRelay<UIFont?> {
        .relay(of: object, \.font)
    }

    var textColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.textColor)
    }

    var shadowColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.shadowColor)
    }

    var shadowOffset: AssociativeTwoWayRelay<CGSize> {
        .relay(of: object, \.shadowOffset)
    }
    
    var attributedText: AssociativeTwoWayRelay<NSAttributedString?> {
        .relay(of: object, \.attributedText)
    }
    
    var highlightedTextColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.highlightedTextColor)
    }

    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }

    var isUserInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isUserInteractionEnabled)
    }

    var isEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isEnabled)
    }
    
    var numberOfLines: AssociativeTwoWayRelay<Int> {
        .relay(of: object, \.numberOfLines)
    }
    
    var adjustsFontSizeToFitWidth: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.adjustsFontSizeToFitWidth)
    }
    
    var minimumScaleFactor: TwoWayRelay<CGFloat> {
        .relay(of: object, \.minimumScaleFactor)
    }
    
    var allowsDefaultTighteningForTruncation: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.allowsDefaultTighteningForTruncation)
    }
    
    var preferredMaxLayoutWidth: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.preferredMaxLayoutWidth)
    }
    
}
#endif
