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
    
    var contentEdgeInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.contentEdgeInsets)
    }
    
    var titleEdgeInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.titleEdgeInsets)
    }
    
    var reversesTitleShadowWhenHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.reversesTitleShadowWhenHighlighted)
    }
    
    var imageEdgeInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.imageEdgeInsets)
    }
    
    var adjustsImageWhenHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.adjustsImageWhenHighlighted)
    }
    
    var adjustsImageWhenDisabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.adjustsImageWhenDisabled)
    }
    
    var showsTouchWhenHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsTouchWhenHighlighted)
    }
    
    @available(iOS 13.4, *)
    var isPointerInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isPointerInteractionEnabled)
    }
    
}
#endif
