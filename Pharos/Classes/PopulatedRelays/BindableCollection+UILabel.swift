//
//  RelayCollection+UILabel.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var textKey: String = "textKey"
private var fontKey: String = "fontKey"
private var textColorKey: String = "textColorKey"
private var shadowColorKey: String = "shadowColorKey"
private var shadowOffsetKey: String = "shadowOffsetKey"
private var attributedTextKey: String = "attributedTextKey"
private var highlightedTextColorKey: String = "highlightedTextColorKey"
private var isHighlightedKey: String = "isHighlightedKey"
private var isUserInteractionEnabledKey: String = "isUserInteractionEnabledKey"
private var isEnabledKey: String = "isEnabledKey"
private var numberOfLinesKey: String = "numberOfLinesKey"
private var adjustsFontSizeToFitWidthKey: String = "adjustsFontSizeToFitWidthKey"
private var minimumScaleFactorKey: String = "minimumScaleFactorKey"
private var allowsDefaultTighteningForTruncationKey: String = "allowsDefaultTighteningForTruncationKey"
private var preferredMaxLayoutWidthKey: String = "preferredMaxLayoutWidthKey"

public extension BindableCollection where Object: UILabel {
    
    // MARK: Two Way Relay
    
    var text: Observable<String?> {
        bindable(of: \.text, key: &textKey)
    }

    var font: Observable<UIFont?> {
        bindable(of: \.font, key: &fontKey)
    }

    var textColor: Observable<UIColor?> {
        bindable(of: \.textColor, key: &textColorKey)
    }

    var shadowColor: Observable<UIColor?> {
        bindable(of: \.shadowColor, key: &shadowColorKey)
    }

    var shadowOffset: Observable<CGSize> {
        bindable(of: \.shadowOffset, key: &shadowOffsetKey)
    }
    
    var attributedText: Observable<NSAttributedString?> {
        bindable(of: \.attributedText, key: &attributedTextKey)
    }
    
    var highlightedTextColor: Observable<UIColor?> {
        bindable(of: \.highlightedTextColor, key: &highlightedTextColorKey)
    }

    var isHighlighted: Observable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }

    var isUserInteractionEnabled: Observable<Bool> {
        bindable(of: \.isUserInteractionEnabled, key: &isUserInteractionEnabledKey)
    }

    var isEnabled: Observable<Bool> {
        bindable(of: \.isEnabled, key: &isEnabledKey)
    }
    
    var numberOfLines: Observable<Int> {
        bindable(of: \.numberOfLines, key: &numberOfLinesKey)
    }
    
    var adjustsFontSizeToFitWidth: Observable<Bool> {
        bindable(of: \.adjustsFontSizeToFitWidth, key: &adjustsFontSizeToFitWidthKey)
    }
    
    var minimumScaleFactor: Observable<CGFloat> {
        bindable(of: \.minimumScaleFactor, key: &minimumScaleFactorKey)
    }
    
    var allowsDefaultTighteningForTruncation: Observable<Bool> {
        bindable(of: \.allowsDefaultTighteningForTruncation, key: &allowsDefaultTighteningForTruncationKey)
    }
    
    var preferredMaxLayoutWidth: Observable<CGFloat> {
        bindable(of: \.preferredMaxLayoutWidth, key: &preferredMaxLayoutWidthKey)
    }
    
}
#endif
