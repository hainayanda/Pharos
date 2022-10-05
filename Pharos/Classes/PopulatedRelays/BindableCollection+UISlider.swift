//
//  RelayCollection+UISlider.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var valueKey: String = "valueKey"
private var minimumValueKey: String = "minimumValueKey"
private var maximumValueKey: String = "maximumValueKey"
private var minimumValueImageKey: String = "minimumValueImageKey"
private var maximumValueImageKey: String = "maximumValueImageKey"
private var isContinuousKey: String = "isContinuousKey"
private var minimumTrackTintColorKey: String = "minimumTrackTintColorKey"
private var maximumTrackTintColorKey: String = "maximumTrackTintColorKey"
private var thumbTintColorKey: String = "thumbTintColorKey"

public extension BindableCollection where Object: UISlider {
    
    // MARK: Two Way Relay
    
    var value: Observable<Float> {
        bindable(of: \.value, key: &valueKey)
    }
    
    var minimumValue: Observable<Float> {
        bindable(of: \.minimumValue, key: &minimumValueKey)
    }
    
    var maximumValue: Observable<Float> {
        bindable(of: \.maximumValue, key: &maximumValueKey)
    }
    
    var minimumValueImage: Observable<UIImage?> {
        bindable(of: \.minimumValueImage, key: &minimumValueImageKey)
    }
    
    var maximumValueImage: Observable<UIImage?> {
        bindable(of: \.maximumValueImage, key: &maximumValueImageKey)
    }
    
    var isContinuous: Observable<Bool> {
        bindable(of: \.isContinuous, key: &isContinuousKey)
    }
    
    var minimumTrackTintColor: Observable<UIColor?> {
        bindable(of: \.minimumTrackTintColor, key: &minimumTrackTintColorKey)
    }
    
    var maximumTrackTintColor: Observable<UIColor?> {
        bindable(of: \.maximumTrackTintColor, key: &maximumTrackTintColorKey)
    }
    
    var thumbTintColor: Observable<UIColor?> {
        bindable(of: \.thumbTintColor, key: &thumbTintColorKey)
    }
    
}
#endif
