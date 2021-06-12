//
//  RelayCollection+UISwitch.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UISwitch: PopulatedRelays {
    public typealias BaseRelayObject = UISwitch
}

public extension RelayCollection where Object: UISwitch {
    
    // MARK: Two Way Relay
    
    var onTintColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.onTintColor)
    }
    
    var thumbTintColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.thumbTintColor)
    }
    
    var onImage: TwoWayRelay<UIImage?> {
        .relay(of: object, \.onImage)
    }
    
    var offImage: TwoWayRelay<UIImage?> {
        .relay(of: object, \.offImage)
    }
    
    @available(iOS 14.0, *)
    var title: TwoWayRelay<String?> {
        .relay(of: object, \.title)
    }
    
    @available(iOS 14.0, *)
    var preferredStyle: TwoWayRelay<UISwitch.Style> {
        .relay(of: object, \.preferredStyle)
    }
    
    var isOn: TwoWayRelay<Bool> {
        .relay(of: object, \.isOn)
    }
    
    // MARK: Value Relay
    
    @available(iOS 14.0, *)
    var style: ValueRelay<UISwitch.Style> {
        .relay(of: object, \.style)
    }
    
}
#endif

