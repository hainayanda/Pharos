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
    
    var text: BindableRelay<String?> {
        bindable(of:\.text)
    }

    var font: BindableRelay<UIFont?> {
        bindable(of:\.font)
    }

    var textColor: BindableRelay<UIColor?> {
        bindable(of:\.textColor)
    }

    var shadowColor: BindableRelay<UIColor?> {
        bindable(of:\.shadowColor)
    }

    var shadowOffset: BindableRelay<CGSize> {
        bindable(of:\.shadowOffset)
    }
    
    var attributedText: BindableRelay<NSAttributedString?> {
        bindable(of:\.attributedText)
    }
    
    var highlightedTextColor: BindableRelay<UIColor?> {
        bindable(of:\.highlightedTextColor)
    }

    var isHighlighted: BindableRelay<Bool> {
        bindable(of:\.isHighlighted)
    }

    var isUserInteractionEnabled: BindableRelay<Bool> {
        bindable(of:\.isUserInteractionEnabled)
    }

    var isEnabled: BindableRelay<Bool> {
        bindable(of:\.isEnabled)
    }
    
    var numberOfLines: BindableRelay<Int> {
        bindable(of:\.numberOfLines)
    }
    
    var adjustsFontSizeToFitWidth: BindableRelay<Bool> {
        bindable(of:\.adjustsFontSizeToFitWidth)
    }
    
    var minimumScaleFactor: BindableRelay<CGFloat> {
        bindable(of:\.minimumScaleFactor)
    }
    
    var allowsDefaultTighteningForTruncation: BindableRelay<Bool> {
        bindable(of:\.allowsDefaultTighteningForTruncation)
    }
    
    var preferredMaxLayoutWidth: BindableRelay<CGFloat> {
        bindable(of:\.preferredMaxLayoutWidth)
    }
    
}
#endif
