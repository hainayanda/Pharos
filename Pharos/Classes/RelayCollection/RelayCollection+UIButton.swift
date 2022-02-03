//
//  RelayCollection+UIButton.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIButton {
    
    // MARK: Two Way Relay
    
    var contentEdgeInsets: BindableRelay<UIEdgeInsets> {
        bindable(of:\.contentEdgeInsets)
    }
    
    var titleEdgeInsets: BindableRelay<UIEdgeInsets> {
        bindable(of:\.titleEdgeInsets)
    }
    
    var reversesTitleShadowWhenHighlighted: BindableRelay<Bool> {
        bindable(of:\.reversesTitleShadowWhenHighlighted)
    }
    
    var imageEdgeInsets: BindableRelay<UIEdgeInsets> {
        bindable(of:\.imageEdgeInsets)
    }
    
    var adjustsImageWhenHighlighted: BindableRelay<Bool> {
        bindable(of:\.adjustsImageWhenHighlighted)
    }
    
    var adjustsImageWhenDisabled: BindableRelay<Bool> {
        bindable(of:\.adjustsImageWhenDisabled)
    }
    
    var showsTouchWhenHighlighted: BindableRelay<Bool> {
        bindable(of:\.showsTouchWhenHighlighted)
    }
    
    @available(iOS 13.4, *)
    var isPointerInteractionEnabled: BindableRelay<Bool> {
        bindable(of:\.isPointerInteractionEnabled)
    }
    
}
#endif
