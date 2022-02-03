//
//  RelayCollection+UISlider.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UISlider {
    
    // MARK: Two Way Relay
    
    var value: BindableRelay<Float> {
        bindable(of:\.value)
    }
    
    var minimumValue: BindableRelay<Float> {
        bindable(of:\.minimumValue)
    }
    
    var maximumValue: BindableRelay<Float> {
        bindable(of:\.maximumValue)
    }
    
    var minimumValueImage: BindableRelay<UIImage?> {
        bindable(of:\.minimumValueImage)
    }
    
    var maximumValueImage: BindableRelay<UIImage?> {
        bindable(of:\.maximumValueImage)
    }
    
    var isContinuous: BindableRelay<Bool> {
        bindable(of:\.isContinuous)
    }
    
    var minimumTrackTintColor: BindableRelay<UIColor?> {
        bindable(of:\.minimumTrackTintColor)
    }
    
    var maximumTrackTintColor: BindableRelay<UIColor?> {
        bindable(of:\.maximumTrackTintColor)
    }
    
    var thumbTintColor: BindableRelay<UIColor?> {
        bindable(of:\.thumbTintColor)
    }
    
}
#endif
