//
//  RelayCollection+UISwitch.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var onTintColorKey: String = "onTintColorKey"
private var thumbTintColorKey: String = "thumbTintColorKey"
private var onImageKey: String = "onImageKey"
private var offImageKey: String = "offImageKey"
private var isOnKey: String = "isOnKey"

public extension BindableCollection where Object: UISwitch {
    
    // MARK: Two Way Relay
    
    var onTintColor: Observable<UIColor?> {
        bindable(of: \.onTintColor, key: &onTintColorKey)
    }
    
    var thumbTintColor: Observable<UIColor?> {
        bindable(of: \.thumbTintColor, key: &thumbTintColorKey)
    }
    
    var onImage: Observable<UIImage?> {
        bindable(of: \.onImage, key: &onImageKey)
    }
    
    var offImage: Observable<UIImage?> {
        bindable(of: \.offImage, key: &offImageKey)
    }
    
    var isOn: Observable<Bool> {
        bindable(of: \.isOn, key: &isOnKey)
    }
    
}
#endif
