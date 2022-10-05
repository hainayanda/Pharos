//
//  RelayCollection+UIButton.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var contentEdgeInsetsKey: String = "contentEdgeInsetsKey"
private var titleEdgeInsetsKey: String = "titleEdgeInsetsKey"
private var reversesTitleShadowWhenHighlightedKey: String = "reversesTitleShadowWhenHighlightedKey"
private var imageEdgeInsetsKey: String = "imageEdgeInsetsKey"
private var adjustsImageWhenHighlightedKey: String = "adjustsImageWhenHighlightedKey"
private var adjustsImageWhenDisabledKey: String = "adjustsImageWhenDisabledKey"
private var showsTouchWhenHighlightedKey: String = "showsTouchWhenHighlightedKey"
private var isPointerInteractionEnabledKey: String = "isPointerInteractionEnabledKey"

public extension BindableCollection where Object: UIButton {
    
    // MARK: Two Way Relay
    
    var contentEdgeInsets: Observable<UIEdgeInsets> {
        bindable(of: \.contentEdgeInsets, key: &contentEdgeInsetsKey)
    }
    
    var titleEdgeInsets: Observable<UIEdgeInsets> {
        bindable(of: \.titleEdgeInsets, key: &titleEdgeInsetsKey)
    }
    
    var reversesTitleShadowWhenHighlighted: Observable<Bool> {
        bindable(of: \.reversesTitleShadowWhenHighlighted, key: &reversesTitleShadowWhenHighlightedKey)
    }
    
    var imageEdgeInsets: Observable<UIEdgeInsets> {
        bindable(of: \.imageEdgeInsets, key: &imageEdgeInsetsKey)
    }
    
    var adjustsImageWhenHighlighted: Observable<Bool> {
        bindable(of: \.adjustsImageWhenHighlighted, key: &adjustsImageWhenHighlightedKey)
    }
    
    var adjustsImageWhenDisabled: Observable<Bool> {
        bindable(of: \.adjustsImageWhenDisabled, key: &adjustsImageWhenDisabledKey)
    }
    
    var showsTouchWhenHighlighted: Observable<Bool> {
        bindable(of: \.showsTouchWhenHighlighted, key: &showsTouchWhenHighlightedKey)
    }
    
    @available(iOS 13.4, *)
    var isPointerInteractionEnabled: Observable<Bool> {
        bindable(of: \.isPointerInteractionEnabled, key: &isPointerInteractionEnabledKey)
    }
    
}
#endif
