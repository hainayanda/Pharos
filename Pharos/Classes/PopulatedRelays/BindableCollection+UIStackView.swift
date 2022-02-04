//
//  RelayCollection+UIStackView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UIStackView {
    
    // MARK: Two Way Relay
    
    var spacing: BindableObservable<CGFloat> {
        bindable(of:\.spacing)
    }
    
    var isBaselineRelativeArrangement: BindableObservable<Bool> {
        bindable(of:\.isBaselineRelativeArrangement)
    }
    
    var isLayoutMarginsRelativeArrangement: BindableObservable<Bool> {
        bindable(of:\.isLayoutMarginsRelativeArrangement)
    }
    
}
#endif
