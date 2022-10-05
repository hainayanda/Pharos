//
//  RelayCollection+UIStepper.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var isContinuousKey: String = "isContinuousKey"
private var autorepeatKey: String = "autorepeatKey"
private var wrapsKey: String = "wrapsKey"
private var valueKey: String = "valueKey"
private var minimumValueKey: String = "minimumValueKey"
private var maximumValueKey: String = "maximumValueKey"
private var stepValueKey: String = "stepValueKey"

public extension BindableCollection where Object: UIStepper {
    
    // MARK: Two Way Relay
    
    var isContinuous: Observable<Bool> {
        bindable(of: \.isContinuous, key: &isContinuousKey)
    }
    
    var autorepeat: Observable<Bool> {
        bindable(of: \.autorepeat, key: &autorepeatKey)
    }
    
    var wraps: Observable<Bool> {
        bindable(of: \.wraps, key: &wrapsKey)
    }
    
    var value: Observable<Double> {
        bindable(of: \.value, key: &valueKey)
    }
    
    var minimumValue: Observable<Double> {
        bindable(of: \.minimumValue, key: &minimumValueKey)
    }
    
    var maximumValue: Observable<Double> {
        bindable(of: \.maximumValue, key: &maximumValueKey)
    }
    
    var stepValue: Observable<Double> {
        bindable(of: \.stepValue, key: &stepValueKey)
    }
}
#endif
