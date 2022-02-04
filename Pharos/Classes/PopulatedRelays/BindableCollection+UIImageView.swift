//
//  BindableCollection+UIImageView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UIImageView {
    
    // MARK: Two Way Relay
    
    var image: BindableObservable<UIImage?> {
        bindable(of:\.image)
    }
    
    var highlightedImage: BindableObservable<UIImage?> {
        bindable(of:\.highlightedImage)
    }

    var isUserInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.isUserInteractionEnabled)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    var animationImages: BindableObservable<[UIImage]?> {
        bindable(of:\.animationImages)
    }

    var highlightedAnimationImages: BindableObservable<[UIImage]?> {
        bindable(of:\.highlightedAnimationImages)
    }
    
    var animationDuration: BindableObservable<TimeInterval> {
        bindable(of:\.animationDuration)
    }

    var animationRepeatCount: BindableObservable<Int> {
        bindable(of:\.animationRepeatCount)
    }
    
}
#endif
