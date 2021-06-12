//
//  RelayCollection+UILabel.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UILabel: PopulatedRelays {
    public typealias BaseRelayObject = UILabel
}

public extension RelayCollection where Object: UILabel {
    
    // MARK: Two Way Relay
    
    var text: TwoWayRelay<String?> {
        .relay(of: object, \.text)
    }

    var font: TwoWayRelay<UIFont?> {
        .relay(of: object, \.font)
    }

    var textColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.textColor)
    }

    var shadowColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.shadowColor)
    }

    var shadowOffset: TwoWayRelay<CGSize> {
        .relay(of: object, \.shadowOffset)
    }

    var textAlignment: TwoWayRelay<NSTextAlignment> {
        .relay(of: object, \.textAlignment)
    }

    var lineBreakMode: TwoWayRelay<NSLineBreakMode> {
        .relay(of: object, \.lineBreakMode)
    }
    
    var attributedText: TwoWayRelay<NSAttributedString?> {
        .relay(of: object, \.attributedText)
    }
    
    var highlightedTextColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.highlightedTextColor)
    }

    var isHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }

    var isUserInteractionEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isUserInteractionEnabled)
    }

    var isEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isEnabled)
    }
    
    var numberOfLines: TwoWayRelay<Int> {
        .relay(of: object, \.numberOfLines)
    }
    
    var adjustsFontSizeToFitWidth: TwoWayRelay<Bool> {
        .relay(of: object, \.adjustsFontSizeToFitWidth)
    }

    var baselineAdjustment: TwoWayRelay<UIBaselineAdjustment> {
        .relay(of: object, \.baselineAdjustment)
    }

    var minimumScaleFactor: TwoWayRelay<CGFloat> {
        .relay(of: object, \.minimumScaleFactor)
    }
    
    var allowsDefaultTighteningForTruncation: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsDefaultTighteningForTruncation)
    }
    
    var lineBreakStrategy: TwoWayRelay<NSParagraphStyle.LineBreakStrategy> {
        .relay(of: object, \.lineBreakStrategy)
    }
    
    var preferredMaxLayoutWidth: TwoWayRelay<CGFloat> {
        .relay(of: object, \.preferredMaxLayoutWidth)
    }
    
}
#endif
