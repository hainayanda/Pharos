//
//  RelayCollection+UIButton.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UIButton {
    
    // MARK: Two Way Relay
    
    var contentEdgeInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.contentEdgeInsets)
    }
    
    var titleEdgeInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.titleEdgeInsets)
    }
    
    var reversesTitleShadowWhenHighlighted: BindableObservable<Bool> {
        bindable(of:\.reversesTitleShadowWhenHighlighted)
    }
    
    var imageEdgeInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.imageEdgeInsets)
    }
    
    var adjustsImageWhenHighlighted: BindableObservable<Bool> {
        bindable(of:\.adjustsImageWhenHighlighted)
    }
    
    var adjustsImageWhenDisabled: BindableObservable<Bool> {
        bindable(of:\.adjustsImageWhenDisabled)
    }
    
    var showsTouchWhenHighlighted: BindableObservable<Bool> {
        bindable(of:\.showsTouchWhenHighlighted)
    }
    
    @available(iOS 13.4, *)
    var isPointerInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.isPointerInteractionEnabled)
    }
    
}
#endif
