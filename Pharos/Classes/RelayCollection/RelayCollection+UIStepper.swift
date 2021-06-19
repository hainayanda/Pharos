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
        .relay(of: object, \.isContinuous)
    }
    
    var autorepeat: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.autorepeat)
    }
    
    var wraps: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.wraps)
    }
    
    var value: AssociativeTwoWayRelay<Double> {
        .relay(of: object, \.value)
    }
    
    var minimumValue: AssociativeTwoWayRelay<Double> {
        .relay(of: object, \.minimumValue)
    }
    
    var maximumValue: AssociativeTwoWayRelay<Double> {
        .relay(of: object, \.maximumValue)
    }
    
    var stepValue: AssociativeTwoWayRelay<Double> {
        .relay(of: object, \.stepValue)
    }
}
#endif
