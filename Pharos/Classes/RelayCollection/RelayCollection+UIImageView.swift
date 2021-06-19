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
        .relay(of: object, \.image)
    }
    
    var highlightedImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: object, \.highlightedImage)
    }

    var isUserInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isUserInteractionEnabled)
    }
    
    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }
    
    var animationImages: AssociativeTwoWayRelay<[UIImage]?> {
        .relay(of: object, \.animationImages)
    }

    var highlightedAnimationImages: AssociativeTwoWayRelay<[UIImage]?> {
        .relay(of: object, \.highlightedAnimationImages)
    }
    
    var animationDuration: AssociativeTwoWayRelay<TimeInterval> {
        .relay(of: object, \.animationDuration)
    }

    var animationRepeatCount: AssociativeTwoWayRelay<Int> {
        .relay(of: object, \.animationRepeatCount)
    }
    
}
#endif
