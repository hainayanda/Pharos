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
        .relay(of: object, \.contentEdgeInsets)
    }
    
    var titleEdgeInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.titleEdgeInsets)
    }
    
    var reversesTitleShadowWhenHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.reversesTitleShadowWhenHighlighted)
    }
    
    var imageEdgeInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.imageEdgeInsets)
    }
    
    var adjustsImageWhenHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.adjustsImageWhenHighlighted)
    }
    
    var adjustsImageWhenDisabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.adjustsImageWhenDisabled)
    }
    
    var showsTouchWhenHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.showsTouchWhenHighlighted)
    }
    
    @available(iOS 13.4, *)
    var isPointerInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isPointerInteractionEnabled)
    }
    
}
#endif
