//
//  RelayCollection+UIView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIView {
    
    // MARK: Two Way Relay

    var isUserInteractionEnabled: BindableRelay<Bool> {
        bindable(of:\.isUserInteractionEnabled)
    }
    
    var tag: BindableRelay<Int> {
        bindable(of:\.tag)
    }
    
    @available(iOS 14.0, *)
    var focusGroupIdentifier: BindableRelay<String?> {
        bindable(of:\.focusGroupIdentifier)
    }
    
    var frame: BindableRelay<CGRect> {
        bindable(of:\.frame)
    }
    
    var bounds: BindableRelay<CGRect> {
        bindable(of:\.bounds)
    }
    
    var center: BindableRelay<CGPoint> {
        bindable(of:\.center)
    }
    
    var contentScaleFactor: BindableRelay<CGFloat> {
        bindable(of:\.contentScaleFactor)
    }
    
    var isMultipleTouchEnabled: BindableRelay<Bool> {
        bindable(of:\.isMultipleTouchEnabled)
    }
    
    var isExclusiveTouch: BindableRelay<Bool> {
        bindable(of:\.isExclusiveTouch)
    }

    var autoresizesSubviews: BindableRelay<Bool> {
        bindable(of:\.autoresizesSubviews)
    }
    
    var layoutMargins: BindableRelay<UIEdgeInsets> {
        bindable(of:\.layoutMargins)
    }
    
    @available(iOS 11.0, *)
    var directionalLayoutMargins: BindableRelay<NSDirectionalEdgeInsets> {
        bindable(of:\.directionalLayoutMargins)
    }
    
    var preservesSuperviewLayoutMargins: BindableRelay<Bool> {
        bindable(of:\.preservesSuperviewLayoutMargins)
    }
    
    @available(iOS 11.0, *)
    var insetsLayoutMarginsFromSafeArea: BindableRelay<Bool> {
        bindable(of:\.insetsLayoutMarginsFromSafeArea)
    }
    
    var clipsToBounds: BindableRelay<Bool> {
        bindable(of:\.clipsToBounds)
    }
    
    var backgroundColor: BindableRelay<UIColor?> {
        bindable(of:\.backgroundColor)
    }
    
    var alpha: BindableRelay<CGFloat> {
        bindable(of:\.alpha)
    }
    
    var isOpaque: BindableRelay<Bool> {
        bindable(of:\.isOpaque)
    }
    
    var clearsContextBeforeDrawing: BindableRelay<Bool> {
        bindable(of:\.clearsContextBeforeDrawing)
    }
    
    var isHidden: BindableRelay<Bool> {
        bindable(of:\.isHidden)
    }
    
    var mask: BindableRelay<UIView?> {
        bindable(of:\.mask)
    }
    
    var tintColor: BindableRelay<UIColor?> {
        bindable(of:\.tintColor)
    }
    
    var translatesAutoresizingMaskIntoConstraints: BindableRelay<Bool> {
        bindable(of:\.translatesAutoresizingMaskIntoConstraints)
    }
    
    var restorationIdentifier: BindableRelay<String?> {
        bindable(of:\.restorationIdentifier)
    }
    
}
#endif
