//
//  RelayCollection+UIView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var isUserInteractionEnabledKey: String = "isUserInteractionEnabledKey"
fileprivate var focusGroupIdentifierKey: String = "focusGroupIdentifierKey"
fileprivate var frameKey: String = "frameKey"
fileprivate var boundsKey: String = "boundsKey"
fileprivate var centerKey: String = "centerKey"
fileprivate var contentScaleFactorKey: String = "contentScaleFactorKey"
fileprivate var isMultipleTouchEnabledKey: String = "isMultipleTouchEnabledKey"
fileprivate var isExclusiveTouchKey: String = "isExclusiveTouchKey"
fileprivate var autoresizesSubviewsKey: String = "autoresizesSubviewsKey"
fileprivate var directionalLayoutMarginsKey: String = "directionalLayoutMarginsKey"
fileprivate var layoutMarginsKey: String = "layoutMarginsKey"
fileprivate var tagKey: String = "tagKey"
fileprivate var preservesSuperviewLayoutMarginsKey: String = "preservesSuperviewLayoutMarginsKey"
fileprivate var insetsLayoutMarginsFromSafeAreaKey: String = "insetsLayoutMarginsFromSafeAreaKey"
fileprivate var clipsToBoundsKey: String = "clipsToBoundsKey"
fileprivate var alphaKey: String = "alphaKey"
fileprivate var isOpaqueKey: String = "isOpaqueKey"
fileprivate var clearsContextBeforeDrawingKey: String = "clearsContextBeforeDrawingKey"
fileprivate var isHiddenKey: String = "isHiddenKey"
fileprivate var backgroundColorKey: String = "backgroundColorKey"
fileprivate var maskKey: String = "maskKey"
fileprivate var tintColorKey: String = "tintColorKey"
fileprivate var translatesAutoresizingMaskIntoConstraintsKey: String = "translatesAutoresizingMaskIntoConstraintsKey"
fileprivate var restorationIdentifierKey: String = "restorationIdentifierKey"

public extension BindableCollection where Object: UIView {
    
    // MARK: Two Way Relay

    var isUserInteractionEnabled: BindableObservable<Bool> {
        bindable(of: \.isUserInteractionEnabled, key: &isUserInteractionEnabledKey)
    }
    
    var tag: BindableObservable<Int> {
        bindable(of: \.tag, key: &tagKey)
    }
    
    @available(iOS 14.0, *)
    var focusGroupIdentifier: BindableObservable<String?> {
        bindable(of: \.focusGroupIdentifier, key: &focusGroupIdentifierKey)
    }
    
    var frame: BindableObservable<CGRect> {
        bindable(of: \.frame, key: &frameKey)
    }
    
    var bounds: BindableObservable<CGRect> {
        bindable(of: \.bounds, key: &boundsKey)
    }
    
    var center: BindableObservable<CGPoint> {
        bindable(of: \.center, key: &centerKey)
    }
    
    var contentScaleFactor: BindableObservable<CGFloat> {
        bindable(of: \.contentScaleFactor, key: &contentScaleFactorKey)
    }
    
    var isMultipleTouchEnabled: BindableObservable<Bool> {
        bindable(of: \.isMultipleTouchEnabled, key: &isMultipleTouchEnabledKey)
    }
    
    var isExclusiveTouch: BindableObservable<Bool> {
        bindable(of: \.isExclusiveTouch, key: &isExclusiveTouchKey)
    }

    var autoresizesSubviews: BindableObservable<Bool> {
        bindable(of: \.autoresizesSubviews, key: &autoresizesSubviewsKey)
    }
    
    var layoutMargins: BindableObservable<UIEdgeInsets> {
        bindable(of: \.layoutMargins, key: &layoutMarginsKey)
    }
    
    @available(iOS 11.0, *)
    var directionalLayoutMargins: BindableObservable<NSDirectionalEdgeInsets> {
        bindable(of: \.directionalLayoutMargins, key: &directionalLayoutMarginsKey)
    }
    
    var preservesSuperviewLayoutMargins: BindableObservable<Bool> {
        bindable(of: \.preservesSuperviewLayoutMargins, key: &preservesSuperviewLayoutMarginsKey)
    }
    
    @available(iOS 11.0, *)
    var insetsLayoutMarginsFromSafeArea: BindableObservable<Bool> {
        bindable(of: \.insetsLayoutMarginsFromSafeArea, key: &insetsLayoutMarginsFromSafeAreaKey)
    }
    
    var clipsToBounds: BindableObservable<Bool> {
        bindable(of: \.clipsToBounds, key: &clipsToBoundsKey)
    }
    
    var backgroundColor: BindableObservable<UIColor?> {
        bindable(of: \.backgroundColor, key: &backgroundColorKey)
    }
    
    var alpha: BindableObservable<CGFloat> {
        bindable(of: \.alpha, key: &alphaKey)
    }
    
    var isOpaque: BindableObservable<Bool> {
        bindable(of: \.isOpaque, key: &isOpaqueKey)
    }
    
    var clearsContextBeforeDrawing: BindableObservable<Bool> {
        bindable(of: \.clearsContextBeforeDrawing, key: &clearsContextBeforeDrawingKey)
    }
    
    var isHidden: BindableObservable<Bool> {
        bindable(of: \.isHidden, key: &isHiddenKey)
    }
    
    var mask: BindableObservable<UIView?> {
        bindable(of: \.mask, key: &maskKey)
    }
    
    var tintColor: BindableObservable<UIColor?> {
        bindable(of: \.tintColor, key: &tintColorKey)
    }
    
    var translatesAutoresizingMaskIntoConstraints: BindableObservable<Bool> {
        bindable(of: \.translatesAutoresizingMaskIntoConstraints, key: &translatesAutoresizingMaskIntoConstraintsKey)
    }
    
    var restorationIdentifier: BindableObservable<String?> {
        bindable(of: \.restorationIdentifier, key: &restorationIdentifierKey)
    }
    
}
#endif
