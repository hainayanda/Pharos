//
//  RelayCollection+UIStepper.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var isContinuousKey: String = "isContinuousKey"
fileprivate var autorepeatKey: String = "autorepeatKey"
fileprivate var wrapsKey: String = "wrapsKey"
fileprivate var valueKey: String = "valueKey"
fileprivate var minimumValueKey: String = "minimumValueKey"
fileprivate var maximumValueKey: String = "maximumValueKey"
fileprivate var stepValueKey: String = "stepValueKey"

public extension BindableCollection where Object: UIStepper {
    
    // MARK: Two Way Relay
    
    var isContinuous: BindableObservable<Bool> {
        bindable(of: \.isContinuous, key: &isContinuousKey)
    }
    
    var autorepeat: BindableObservable<Bool> {
        bindable(of: \.autorepeat, key: &autorepeatKey)
    }
    
    var wraps: BindableObservable<Bool> {
        bindable(of: \.wraps, key: &wrapsKey)
    }
    
    var value: BindableObservable<Double> {
        bindable(of: \.value, key: &valueKey)
    }
    
    var minimumValue: BindableObservable<Double> {
        bindable(of: \.minimumValue, key: &minimumValueKey)
    }
    
    var maximumValue: BindableObservable<Double> {
        bindable(of: \.maximumValue, key: &maximumValueKey)
    }
    
    var stepValue: BindableObservable<Double> {
        bindable(of: \.stepValue, key: &stepValueKey)
    }
}
#endif
