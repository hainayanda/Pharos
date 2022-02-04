//
//  RelayCollection+UIView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UIView {
    
    // MARK: Two Way Relay

    var isUserInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.isUserInteractionEnabled)
    }
    
    var tag: BindableObservable<Int> {
        bindable(of:\.tag)
    }
    
    @available(iOS 14.0, *)
    var focusGroupIdentifier: BindableObservable<String?> {
        bindable(of:\.focusGroupIdentifier)
    }
    
    var frame: BindableObservable<CGRect> {
        bindable(of:\.frame)
    }
    
    var bounds: BindableObservable<CGRect> {
        bindable(of:\.bounds)
    }
    
    var center: BindableObservable<CGPoint> {
        bindable(of:\.center)
    }
    
    var contentScaleFactor: BindableObservable<CGFloat> {
        bindable(of:\.contentScaleFactor)
    }
    
    var isMultipleTouchEnabled: BindableObservable<Bool> {
        bindable(of:\.isMultipleTouchEnabled)
    }
    
    var isExclusiveTouch: BindableObservable<Bool> {
        bindable(of:\.isExclusiveTouch)
    }

    var autoresizesSubviews: BindableObservable<Bool> {
        bindable(of:\.autoresizesSubviews)
    }
    
    var layoutMargins: BindableObservable<UIEdgeInsets> {
        bindable(of:\.layoutMargins)
    }
    
    @available(iOS 11.0, *)
    var directionalLayoutMargins: BindableObservable<NSDirectionalEdgeInsets> {
        bindable(of:\.directionalLayoutMargins)
    }
    
    var preservesSuperviewLayoutMargins: BindableObservable<Bool> {
        bindable(of:\.preservesSuperviewLayoutMargins)
    }
    
    @available(iOS 11.0, *)
    var insetsLayoutMarginsFromSafeArea: BindableObservable<Bool> {
        bindable(of:\.insetsLayoutMarginsFromSafeArea)
    }
    
    var clipsToBounds: BindableObservable<Bool> {
        bindable(of:\.clipsToBounds)
    }
    
    var backgroundColor: BindableObservable<UIColor?> {
        bindable(of:\.backgroundColor)
    }
    
    var alpha: BindableObservable<CGFloat> {
        bindable(of:\.alpha)
    }
    
    var isOpaque: BindableObservable<Bool> {
        bindable(of:\.isOpaque)
    }
    
    var clearsContextBeforeDrawing: BindableObservable<Bool> {
        bindable(of:\.clearsContextBeforeDrawing)
    }
    
    var isHidden: BindableObservable<Bool> {
        bindable(of:\.isHidden)
    }
    
    var mask: BindableObservable<UIView?> {
        bindable(of:\.mask)
    }
    
    var tintColor: BindableObservable<UIColor?> {
        bindable(of:\.tintColor)
    }
    
    var translatesAutoresizingMaskIntoConstraints: BindableObservable<Bool> {
        bindable(of:\.translatesAutoresizingMaskIntoConstraints)
    }
    
    var restorationIdentifier: BindableObservable<String?> {
        bindable(of:\.restorationIdentifier)
    }
    
}
#endif
