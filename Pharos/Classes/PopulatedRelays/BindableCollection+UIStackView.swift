//
//  RelayCollection+UIStackView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var spacingKey: String = "spacingKey"
private var isBaselineRelativeArrangementKey: String = "isBaselineRelativeArrangementKey"
private var isLayoutMarginsRelativeArrangementKey: String = "isLayoutMarginsRelativeArrangementKey"

public extension BindableCollection where Object: UIStackView {
    
    // MARK: Two Way Relay
    
    var spacing: Observable<CGFloat> {
        bindable(of: \.spacing, key: &spacingKey)
    }
    
    var isBaselineRelativeArrangement: Observable<Bool> {
        bindable(of: \.isBaselineRelativeArrangement, key: &isBaselineRelativeArrangementKey)
    }
    
    var isLayoutMarginsRelativeArrangement: Observable<Bool> {
        bindable(of: \.isLayoutMarginsRelativeArrangement, key: &isLayoutMarginsRelativeArrangementKey)
    }
    
}
#endif
