//
//  RelayCollection+UISwitch.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UISwitch {
    
    // MARK: Two Way Relay
    
    var onTintColor: BindableObservable<UIColor?> {
        bindable(of:\.onTintColor)
    }
    
    var thumbTintColor: BindableObservable<UIColor?> {
        bindable(of:\.thumbTintColor)
    }
    
    var onImage: BindableObservable<UIImage?> {
        bindable(of:\.onImage)
    }
    
    var offImage: BindableObservable<UIImage?> {
        bindable(of:\.offImage)
    }
    
    var isOn: BindableObservable<Bool> {
        bindable(of:\.isOn)
    }
    
}
#endif

