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
    
    var image: BindableRelay<UIImage?> {
        bindable(of:\.image)
    }
    
    var highlightedImage: BindableRelay<UIImage?> {
        bindable(of:\.highlightedImage)
    }

    var isUserInteractionEnabled: BindableRelay<Bool> {
        bindable(of:\.isUserInteractionEnabled)
    }
    
    var isHighlighted: BindableRelay<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    var animationImages: BindableRelay<[UIImage]?> {
        bindable(of:\.animationImages)
    }

    var highlightedAnimationImages: BindableRelay<[UIImage]?> {
        bindable(of:\.highlightedAnimationImages)
    }
    
    var animationDuration: BindableRelay<TimeInterval> {
        bindable(of:\.animationDuration)
    }

    var animationRepeatCount: BindableRelay<Int> {
        bindable(of:\.animationRepeatCount)
    }
    
}
#endif
