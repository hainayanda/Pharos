//
//  BindableCollection+UIImageView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var imageKey: String = "imageKey"
fileprivate var highlightedImageKey: String = "highlightedImageKey"
fileprivate var isUserInteractionEnabledKey: String = "isUserInteractionEnabledKey"
fileprivate var isHighlightedKey: String = "isHighlightedKey"
fileprivate var animationImagesKey: String = "animationImagesKey"
fileprivate var highlightedAnimationImagesKey: String = "highlightedAnimationImagesKey"
fileprivate var animationDurationKey: String = "animationDurationKey"
fileprivate var animationRepeatCountKey: String = "animationDurationKey"

public extension BindableCollection where Object: UIImageView {
    
    // MARK: Two Way Relay
    
    var image: BindableObservable<UIImage?> {
        bindable(of: \.image, key: &imageKey)
    }
    
    var highlightedImage: BindableObservable<UIImage?> {
        bindable(of: \.highlightedImage, key: &highlightedImageKey)
    }

    var isUserInteractionEnabled: BindableObservable<Bool> {
        bindable(of: \.isUserInteractionEnabled, key: &isUserInteractionEnabledKey)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    var animationImages: BindableObservable<[UIImage]?> {
        bindable(of: \.animationImages, key: &animationImagesKey)
    }

    var highlightedAnimationImages: BindableObservable<[UIImage]?> {
        bindable(of: \.highlightedAnimationImages, key: &highlightedAnimationImagesKey)
    }
    
    var animationDuration: BindableObservable<TimeInterval> {
        bindable(of: \.animationDuration, key: &animationDurationKey)
    }

    var animationRepeatCount: BindableObservable<Int> {
        bindable(of: \.animationRepeatCount, key: &animationRepeatCountKey)
    }
    
}
#endif
