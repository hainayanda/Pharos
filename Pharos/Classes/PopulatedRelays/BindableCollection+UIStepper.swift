//
//  RelayCollection+UIStepper.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UIStepper {
    
    // MARK: Two Way Relay
    
    var isContinuous: BindableObservable<Bool> {
        bindable(of:\.isContinuous)
    }
    
    var autorepeat: BindableObservable<Bool> {
        bindable(of:\.autorepeat)
    }
    
    var wraps: BindableObservable<Bool> {
        bindable(of:\.wraps)
    }
    
    var value: BindableObservable<Double> {
        bindable(of:\.value)
    }
    
    var minimumValue: BindableObservable<Double> {
        bindable(of:\.minimumValue)
    }
    
    var maximumValue: BindableObservable<Double> {
        bindable(of:\.maximumValue)
    }
    
    var stepValue: BindableObservable<Double> {
        bindable(of:\.stepValue)
    }
}
#endif
