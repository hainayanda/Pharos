//
//  RelayCollection+UIImageView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIImageView {
    
    // MARK: Two Way Relay
    
    var image: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.image)
    }
    
    var highlightedImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.highlightedImage)
    }

    var isUserInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isUserInteractionEnabled)
    }
    
    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isHighlighted)
    }
    
    var animationImages: AssociativeTwoWayRelay<[UIImage]?> {
        .relay(of: underlyingObject, \.animationImages)
    }

    var highlightedAnimationImages: AssociativeTwoWayRelay<[UIImage]?> {
        .relay(of: underlyingObject, \.highlightedAnimationImages)
    }
    
    var animationDuration: AssociativeTwoWayRelay<TimeInterval> {
        .relay(of: underlyingObject, \.animationDuration)
    }

    var animationRepeatCount: AssociativeTwoWayRelay<Int> {
        .relay(of: underlyingObject, \.animationRepeatCount)
    }
    
}
#endif
