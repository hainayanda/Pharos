//
//  RelayCollection+UIButton.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var contentEdgeInsetsKey: String = "contentEdgeInsetsKey"
fileprivate var titleEdgeInsetsKey: String = "titleEdgeInsetsKey"
fileprivate var reversesTitleShadowWhenHighlightedKey: String = "reversesTitleShadowWhenHighlightedKey"
fileprivate var imageEdgeInsetsKey: String = "imageEdgeInsetsKey"
fileprivate var adjustsImageWhenHighlightedKey: String = "adjustsImageWhenHighlightedKey"
fileprivate var adjustsImageWhenDisabledKey: String = "adjustsImageWhenDisabledKey"
fileprivate var showsTouchWhenHighlightedKey: String = "showsTouchWhenHighlightedKey"
fileprivate var isPointerInteractionEnabledKey: String = "isPointerInteractionEnabledKey"

public extension BindableCollection where Object: UIButton {
    
    // MARK: Two Way Relay
    
    var contentEdgeInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.contentEdgeInsets, key: &contentEdgeInsetsKey)
    }
    
    var titleEdgeInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.titleEdgeInsets, key: &titleEdgeInsetsKey)
    }
    
    var reversesTitleShadowWhenHighlighted: BindableObservable<Bool> {
        bindable(of:\.reversesTitleShadowWhenHighlighted, key: &reversesTitleShadowWhenHighlightedKey)
    }
    
    var imageEdgeInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.imageEdgeInsets, key: &imageEdgeInsetsKey)
    }
    
    var adjustsImageWhenHighlighted: BindableObservable<Bool> {
        bindable(of:\.adjustsImageWhenHighlighted, key: &adjustsImageWhenHighlightedKey)
    }
    
    var adjustsImageWhenDisabled: BindableObservable<Bool> {
        bindable(of:\.adjustsImageWhenDisabled, key: &adjustsImageWhenDisabledKey)
    }
    
    var showsTouchWhenHighlighted: BindableObservable<Bool> {
        bindable(of:\.showsTouchWhenHighlighted, key: &showsTouchWhenHighlightedKey)
    }
    
    @available(iOS 13.4, *)
    var isPointerInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.isPointerInteractionEnabled, key: &isPointerInteractionEnabledKey)
    }
    
}
#endif
