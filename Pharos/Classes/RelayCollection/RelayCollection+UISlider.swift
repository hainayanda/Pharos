//
//  RelayCollection+UISlider.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UISlider: PopulatedRelays {
    public typealias BaseRelayObject = UISlider
}

public extension RelayCollection where Object: UISlider {
    
    // MARK: Two Way Relay
    
    var value: TwoWayRelay<Float> {
        .relay(of: object, \.value)
    }
    
    var minimumValue: TwoWayRelay<Float> {
        .relay(of: object, \.minimumValue)
    }
    
    var maximumValue: TwoWayRelay<Float> {
        .relay(of: object, \.maximumValue)
    }
    
    var minimumValueImage: TwoWayRelay<UIImage?> {
        .relay(of: object, \.minimumValueImage)
    }
    
    var maximumValueImage: TwoWayRelay<UIImage?> {
        .relay(of: object, \.maximumValueImage)
    }
    
    var isContinuous: TwoWayRelay<Bool> {
        .relay(of: object, \.isContinuous)
    }
    
    var minimumTrackTintColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.minimumTrackTintColor)
    }
    
    var maximumTrackTintColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.maximumTrackTintColor)
    }
    
    var thumbTintColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.thumbTintColor)
    }
    
    // MARK: Value Relay
    
    var currentThumbImage: ValueRelay<UIImage?> {
        .relay(of: object, \.currentThumbImage)
    }
    
    var currentMinimumTrackImage: ValueRelay<UIImage?> {
        .relay(of: object, \.currentMinimumTrackImage)
    }
    
    var currentMaximumTrackImage: ValueRelay<UIImage?> {
        .relay(of: object, \.currentMaximumTrackImage)
    }
    
}
#endif
