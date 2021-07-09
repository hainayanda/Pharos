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
    
    var value: AssociativeTwoWayRelay<Float> {
        .relay(of: underlyingObject, \.value)
    }
    
    var minimumValue: AssociativeTwoWayRelay<Float> {
        .relay(of: underlyingObject, \.minimumValue)
    }
    
    var maximumValue: AssociativeTwoWayRelay<Float> {
        .relay(of: underlyingObject, \.maximumValue)
    }
    
    var minimumValueImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.minimumValueImage)
    }
    
    var maximumValueImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.maximumValueImage)
    }
    
    var isContinuous: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isContinuous)
    }
    
    var minimumTrackTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.minimumTrackTintColor)
    }
    
    var maximumTrackTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.maximumTrackTintColor)
    }
    
    var thumbTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.thumbTintColor)
    }
    
}
#endif
