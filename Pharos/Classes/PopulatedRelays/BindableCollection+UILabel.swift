//
//  RelayCollection+UILabel.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var textKey: String = "textKey"
fileprivate var fontKey: String = "fontKey"
fileprivate var textColorKey: String = "textColorKey"
fileprivate var shadowColorKey: String = "shadowColorKey"
fileprivate var shadowOffsetKey: String = "shadowOffsetKey"
fileprivate var attributedTextKey: String = "attributedTextKey"
fileprivate var highlightedTextColorKey: String = "highlightedTextColorKey"
fileprivate var isHighlightedKey: String = "isHighlightedKey"
fileprivate var isUserInteractionEnabledKey: String = "isUserInteractionEnabledKey"
fileprivate var isEnabledKey: String = "isEnabledKey"
fileprivate var numberOfLinesKey: String = "numberOfLinesKey"
fileprivate var adjustsFontSizeToFitWidthKey: String = "adjustsFontSizeToFitWidthKey"
fileprivate var minimumScaleFactorKey: String = "minimumScaleFactorKey"
fileprivate var allowsDefaultTighteningForTruncationKey: String = "allowsDefaultTighteningForTruncationKey"
fileprivate var preferredMaxLayoutWidthKey: String = "preferredMaxLayoutWidthKey"

public extension BindableCollection where Object: UILabel {
    
    // MARK: Two Way Relay
    
    var text: BindableObservable<String?> {
        bindable(of: \.text, key: &textKey)
    }

    var font: BindableObservable<UIFont?> {
        bindable(of: \.font, key: &fontKey)
    }

    var textColor: BindableObservable<UIColor?> {
        bindable(of: \.textColor, key: &textColorKey)
    }

    var shadowColor: BindableObservable<UIColor?> {
        bindable(of: \.shadowColor, key: &shadowColorKey)
    }

    var shadowOffset: BindableObservable<CGSize> {
        bindable(of: \.shadowOffset, key: &shadowOffsetKey)
    }
    
    var attributedText: BindableObservable<NSAttributedString?> {
        bindable(of: \.attributedText, key: &attributedTextKey)
    }
    
    var highlightedTextColor: BindableObservable<UIColor?> {
        bindable(of: \.highlightedTextColor, key: &highlightedTextColorKey)
    }

    var isHighlighted: BindableObservable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }

    var isUserInteractionEnabled: BindableObservable<Bool> {
        bindable(of: \.isUserInteractionEnabled, key: &isUserInteractionEnabledKey)
    }

    var isEnabled: BindableObservable<Bool> {
        bindable(of: \.isEnabled, key: &isEnabledKey)
    }
    
    var numberOfLines: BindableObservable<Int> {
        bindable(of: \.numberOfLines, key: &numberOfLinesKey)
    }
    
    var adjustsFontSizeToFitWidth: BindableObservable<Bool> {
        bindable(of: \.adjustsFontSizeToFitWidth, key: &adjustsFontSizeToFitWidthKey)
    }
    
    var minimumScaleFactor: BindableObservable<CGFloat> {
        bindable(of: \.minimumScaleFactor, key: &minimumScaleFactorKey)
    }
    
    var allowsDefaultTighteningForTruncation: BindableObservable<Bool> {
        bindable(of: \.allowsDefaultTighteningForTruncation, key: &allowsDefaultTighteningForTruncationKey)
    }
    
    var preferredMaxLayoutWidth: BindableObservable<CGFloat> {
        bindable(of: \.preferredMaxLayoutWidth, key: &preferredMaxLayoutWidthKey)
    }
    
}
#endif
