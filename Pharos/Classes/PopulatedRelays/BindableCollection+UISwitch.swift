//
//  RelayCollection+UISwitch.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var onTintColorKey: String = "onTintColorKey"
fileprivate var thumbTintColorKey: String = "thumbTintColorKey"
fileprivate var onImageKey: String = "onImageKey"
fileprivate var offImageKey: String = "offImageKey"
fileprivate var isOnKey: String = "isOnKey"

public extension BindableCollection where Object: UISwitch {
    
    // MARK: Two Way Relay
    
    var onTintColor: BindableObservable<UIColor?> {
        bindable(of: \.onTintColor, key: &onTintColorKey)
    }
    
    var thumbTintColor: BindableObservable<UIColor?> {
        bindable(of: \.thumbTintColor, key: &thumbTintColorKey)
    }
    
    var onImage: BindableObservable<UIImage?> {
        bindable(of: \.onImage, key: &onImageKey)
    }
    
    var offImage: BindableObservable<UIImage?> {
        bindable(of: \.offImage, key: &offImageKey)
    }
    
    var isOn: BindableObservable<Bool> {
        bindable(of: \.isOn, key: &isOnKey)
    }
    
}
#endif

