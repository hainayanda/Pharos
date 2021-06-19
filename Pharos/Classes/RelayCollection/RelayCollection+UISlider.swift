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
        .relay(of: object, \.value)
    }
    
    var minimumValue: AssociativeTwoWayRelay<Float> {
        .relay(of: object, \.minimumValue)
    }
    
    var maximumValue: AssociativeTwoWayRelay<Float> {
        .relay(of: object, \.maximumValue)
    }
    
    var minimumValueImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: object, \.minimumValueImage)
    }
    
    var maximumValueImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: object, \.maximumValueImage)
    }
    
    var isContinuous: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isContinuous)
    }
    
    var minimumTrackTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.minimumTrackTintColor)
    }
    
    var maximumTrackTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.maximumTrackTintColor)
    }
    
    var thumbTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.thumbTintColor)
    }
    
}
#endif
