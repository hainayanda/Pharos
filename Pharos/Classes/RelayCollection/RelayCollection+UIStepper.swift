//
//  RelayCollection+UIStepper.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIStepper {
    
    // MARK: Two Way Relay
    
    var isContinuous: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isContinuous)
    }
    
    var autorepeat: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.autorepeat)
    }
    
    var wraps: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.wraps)
    }
    
    var value: AssociativeTwoWayRelay<Double> {
        .relay(of: underlyingObject, \.value)
    }
    
    var minimumValue: AssociativeTwoWayRelay<Double> {
        .relay(of: underlyingObject, \.minimumValue)
    }
    
    var maximumValue: AssociativeTwoWayRelay<Double> {
        .relay(of: underlyingObject, \.maximumValue)
    }
    
    var stepValue: AssociativeTwoWayRelay<Double> {
        .relay(of: underlyingObject, \.stepValue)
    }
}
#endif
