//
//  RelayCollection+UILabel.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UILabel {
    
    // MARK: Two Way Relay
    
    var text: BindableObservable<String?> {
        bindable(of:\.text)
    }

    var font: BindableObservable<UIFont?> {
        bindable(of:\.font)
    }

    var textColor: BindableObservable<UIColor?> {
        bindable(of:\.textColor)
    }

    var shadowColor: BindableObservable<UIColor?> {
        bindable(of:\.shadowColor)
    }

    var shadowOffset: BindableObservable<CGSize> {
        bindable(of:\.shadowOffset)
    }
    
    var attributedText: BindableObservable<NSAttributedString?> {
        bindable(of:\.attributedText)
    }
    
    var highlightedTextColor: BindableObservable<UIColor?> {
        bindable(of:\.highlightedTextColor)
    }

    var isHighlighted: BindableObservable<Bool> {
        bindable(of:\.isHighlighted)
    }

    var isUserInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.isUserInteractionEnabled)
    }

    var isEnabled: BindableObservable<Bool> {
        bindable(of:\.isEnabled)
    }
    
    var numberOfLines: BindableObservable<Int> {
        bindable(of:\.numberOfLines)
    }
    
    var adjustsFontSizeToFitWidth: BindableObservable<Bool> {
        bindable(of:\.adjustsFontSizeToFitWidth)
    }
    
    var minimumScaleFactor: BindableObservable<CGFloat> {
        bindable(of:\.minimumScaleFactor)
    }
    
    var allowsDefaultTighteningForTruncation: BindableObservable<Bool> {
        bindable(of:\.allowsDefaultTighteningForTruncation)
    }
    
    var preferredMaxLayoutWidth: BindableObservable<CGFloat> {
        bindable(of:\.preferredMaxLayoutWidth)
    }
    
}
#endif
