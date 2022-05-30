//
//  RelayCollection+UIStackView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var spacingKey: String = "spacingKey"
fileprivate var isBaselineRelativeArrangementKey: String = "isBaselineRelativeArrangementKey"
fileprivate var isLayoutMarginsRelativeArrangementKey: String = "isLayoutMarginsRelativeArrangementKey"

public extension BindableCollection where Object: UIStackView {
    
    // MARK: Two Way Relay
    
    var spacing: BindableObservable<CGFloat> {
        bindable(of: \.spacing, key: &spacingKey)
    }
    
    var isBaselineRelativeArrangement: BindableObservable<Bool> {
        bindable(of: \.isBaselineRelativeArrangement, key: &isBaselineRelativeArrangementKey)
    }
    
    var isLayoutMarginsRelativeArrangement: BindableObservable<Bool> {
        bindable(of: \.isLayoutMarginsRelativeArrangement, key: &isLayoutMarginsRelativeArrangementKey)
    }
    
}
#endif
