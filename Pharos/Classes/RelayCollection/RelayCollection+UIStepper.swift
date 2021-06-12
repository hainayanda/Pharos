//
//  RelayCollection+UIStepper.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIStepper: PopulatedRelays {
    public typealias BaseRelayObject = UIStepper
}

public extension RelayCollection where Object: UIStepper {
    
    // MARK: Two Way Relay
    
    var isContinuous: TwoWayRelay<Bool> {
        .relay(of: object, \.isContinuous)
    }
    
    var autorepeat: TwoWayRelay<Bool> {
        .relay(of: object, \.autorepeat)
    }
    
    var wraps: TwoWayRelay<Bool> {
        .relay(of: object, \.wraps)
    }
    
    var value: TwoWayRelay<Double> {
        .relay(of: object, \.value)
    }
    
    var minimumValue: TwoWayRelay<Double> {
        .relay(of: object, \.minimumValue)
    }
    
    var maximumValue: TwoWayRelay<Double> {
        .relay(of: object, \.maximumValue)
    }
    
    var stepValue: TwoWayRelay<Double> {
        .relay(of: object, \.stepValue)
    }
}
#endif
