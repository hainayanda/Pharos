//
//  RelayCollection+UISwitch.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UISwitch {
    
    // MARK: Two Way Relay
    
    var onTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.onTintColor)
    }
    
    var thumbTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.thumbTintColor)
    }
    
    var onImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.onImage)
    }
    
    var offImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.offImage)
    }
    
    var isOn: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isOn)
    }
    
}
#endif

