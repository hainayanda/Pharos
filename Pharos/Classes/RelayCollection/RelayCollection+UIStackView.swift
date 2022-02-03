//
//  RelayCollection+UIStackView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIStackView {
    
    // MARK: Two Way Relay
    
    var spacing: BindableRelay<CGFloat> {
        bindable(of:\.spacing)
    }
    
    var isBaselineRelativeArrangement: BindableRelay<Bool> {
        bindable(of:\.isBaselineRelativeArrangement)
    }
    
    var isLayoutMarginsRelativeArrangement: BindableRelay<Bool> {
        bindable(of:\.isLayoutMarginsRelativeArrangement)
    }
    
}
#endif
