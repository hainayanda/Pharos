//
//  RelayCollection+UIStepper.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIStepper {
    
    // MARK: Two Way Relay
    
    var isContinuous: BindableRelay<Bool> {
        bindable(of:\.isContinuous)
    }
    
    var autorepeat: BindableRelay<Bool> {
        bindable(of:\.autorepeat)
    }
    
    var wraps: BindableRelay<Bool> {
        bindable(of:\.wraps)
    }
    
    var value: BindableRelay<Double> {
        bindable(of:\.value)
    }
    
    var minimumValue: BindableRelay<Double> {
        bindable(of:\.minimumValue)
    }
    
    var maximumValue: BindableRelay<Double> {
        bindable(of:\.maximumValue)
    }
    
    var stepValue: BindableRelay<Double> {
        bindable(of:\.stepValue)
    }
}
#endif
