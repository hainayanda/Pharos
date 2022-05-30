//
//  RelayCollection+UISlider.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var valueKey: String = "valueKey"
fileprivate var minimumValueKey: String = "minimumValueKey"
fileprivate var maximumValueKey: String = "maximumValueKey"
fileprivate var minimumValueImageKey: String = "minimumValueImageKey"
fileprivate var maximumValueImageKey: String = "maximumValueImageKey"
fileprivate var isContinuousKey: String = "isContinuousKey"
fileprivate var minimumTrackTintColorKey: String = "minimumTrackTintColorKey"
fileprivate var maximumTrackTintColorKey: String = "maximumTrackTintColorKey"
fileprivate var thumbTintColorKey: String = "thumbTintColorKey"

public extension BindableCollection where Object: UISlider {
    
    // MARK: Two Way Relay
    
    var value: BindableObservable<Float> {
        bindable(of: \.value, key: &valueKey)
    }
    
    var minimumValue: BindableObservable<Float> {
        bindable(of: \.minimumValue, key: &minimumValueKey)
    }
    
    var maximumValue: BindableObservable<Float> {
        bindable(of: \.maximumValue, key: &maximumValueKey)
    }
    
    var minimumValueImage: BindableObservable<UIImage?> {
        bindable(of: \.minimumValueImage, key: &minimumValueImageKey)
    }
    
    var maximumValueImage: BindableObservable<UIImage?> {
        bindable(of: \.maximumValueImage, key: &maximumValueImageKey)
    }
    
    var isContinuous: BindableObservable<Bool> {
        bindable(of: \.isContinuous, key: &isContinuousKey)
    }
    
    var minimumTrackTintColor: BindableObservable<UIColor?> {
        bindable(of: \.minimumTrackTintColor, key: &minimumTrackTintColorKey)
    }
    
    var maximumTrackTintColor: BindableObservable<UIColor?> {
        bindable(of: \.maximumTrackTintColor, key: &maximumTrackTintColorKey)
    }
    
    var thumbTintColor: BindableObservable<UIColor?> {
        bindable(of: \.thumbTintColor, key: &thumbTintColorKey)
    }
    
}
#endif
