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
    
    var onTintColor: BindableRelay<UIColor?> {
        bindable(of:\.onTintColor)
    }
    
    var thumbTintColor: BindableRelay<UIColor?> {
        bindable(of:\.thumbTintColor)
    }
    
    var onImage: BindableRelay<UIImage?> {
        bindable(of:\.onImage)
    }
    
    var offImage: BindableRelay<UIImage?> {
        bindable(of:\.offImage)
    }
    
    var isOn: BindableRelay<Bool> {
        bindable(of:\.isOn)
    }
    
}
#endif

