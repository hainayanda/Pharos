//
//  RelayCollection+UIImageView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIImageView: PopulatedRelays {
    public typealias BaseRelayObject = UIImageView
}

public extension RelayCollection where Object: UIImageView {
    
    // MARK: Two Way Relay
    
    var image: TwoWayRelay<UIImage?> {
        .relay(of: object, \.image)
    }

    @available(iOS 3.0, *)
    var highlightedImage: TwoWayRelay<UIImage?> {
        .relay(of: object, \.highlightedImage)
    }

    @available(iOS 13.0, *)
    var preferredSymbolConfiguration: TwoWayRelay<UIImage.SymbolConfiguration?> {
        .relay(of: object, \.preferredSymbolConfiguration)
    }

    var isUserInteractionEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isUserInteractionEnabled)
    }

    
    @available(iOS 3.0, *)
    var isHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }
    
    var animationImages: TwoWayRelay<[UIImage]?> {
        .relay(of: object, \.animationImages)
    }

    var highlightedAnimationImages: TwoWayRelay<[UIImage]?> {
        .relay(of: object, \.highlightedAnimationImages)
    }

    
    var animationDuration: TwoWayRelay<TimeInterval> {
        .relay(of: object, \.animationDuration)
    }

    var animationRepeatCount: TwoWayRelay<Int> {
        .relay(of: object, \.animationRepeatCount)
    }
    
    // MARK: Value Relay
    
    var isAnimating: ValueRelay<Bool> {
        .relay(of: object, \.isAnimating)
    }
    
}
#endif
