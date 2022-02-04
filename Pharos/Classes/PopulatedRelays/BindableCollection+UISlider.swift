//
//  RelayCollection+UISlider.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UISlider {
    
    // MARK: Two Way Relay
    
    var value: BindableObservable<Float> {
        bindable(of:\.value)
    }
    
    var minimumValue: BindableObservable<Float> {
        bindable(of:\.minimumValue)
    }
    
    var maximumValue: BindableObservable<Float> {
        bindable(of:\.maximumValue)
    }
    
    var minimumValueImage: BindableObservable<UIImage?> {
        bindable(of:\.minimumValueImage)
    }
    
    var maximumValueImage: BindableObservable<UIImage?> {
        bindable(of:\.maximumValueImage)
    }
    
    var isContinuous: BindableObservable<Bool> {
        bindable(of:\.isContinuous)
    }
    
    var minimumTrackTintColor: BindableObservable<UIColor?> {
        bindable(of:\.minimumTrackTintColor)
    }
    
    var maximumTrackTintColor: BindableObservable<UIColor?> {
        bindable(of:\.maximumTrackTintColor)
    }
    
    var thumbTintColor: BindableObservable<UIColor?> {
        bindable(of:\.thumbTintColor)
    }
    
}
#endif
