//
//  BindableCollection+UIImageView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var imageKey: String = "imageKey"
private var highlightedImageKey: String = "highlightedImageKey"
private var isUserInteractionEnabledKey: String = "isUserInteractionEnabledKey"
private var isHighlightedKey: String = "isHighlightedKey"
private var animationImagesKey: String = "animationImagesKey"
private var highlightedAnimationImagesKey: String = "highlightedAnimationImagesKey"
private var animationDurationKey: String = "animationDurationKey"
private var animationRepeatCountKey: String = "animationDurationKey"

public extension BindableCollection where Object: UIImageView {
    
    // MARK: Two Way Relay
    
    var image: Observable<UIImage?> {
        bindable(of: \.image, key: &imageKey)
    }
    
    var highlightedImage: Observable<UIImage?> {
        bindable(of: \.highlightedImage, key: &highlightedImageKey)
    }

    var isUserInteractionEnabled: Observable<Bool> {
        bindable(of: \.isUserInteractionEnabled, key: &isUserInteractionEnabledKey)
    }
    
    var isHighlighted: Observable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    var animationImages: Observable<[UIImage]?> {
        bindable(of: \.animationImages, key: &animationImagesKey)
    }

    var highlightedAnimationImages: Observable<[UIImage]?> {
        bindable(of: \.highlightedAnimationImages, key: &highlightedAnimationImagesKey)
    }
    
    var animationDuration: Observable<TimeInterval> {
        bindable(of: \.animationDuration, key: &animationDurationKey)
    }

    var animationRepeatCount: Observable<Int> {
        bindable(of: \.animationRepeatCount, key: &animationRepeatCountKey)
    }
    
}
#endif
