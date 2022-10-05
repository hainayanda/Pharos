//
//  RelayCollection+UIView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var isUserInteractionEnabledKey: String = "isUserInteractionEnabledKey"
private var focusGroupIdentifierKey: String = "focusGroupIdentifierKey"
private var frameKey: String = "frameKey"
private var boundsKey: String = "boundsKey"
private var centerKey: String = "centerKey"
private var contentScaleFactorKey: String = "contentScaleFactorKey"
private var isMultipleTouchEnabledKey: String = "isMultipleTouchEnabledKey"
private var isExclusiveTouchKey: String = "isExclusiveTouchKey"
private var autoresizesSubviewsKey: String = "autoresizesSubviewsKey"
private var directionalLayoutMarginsKey: String = "directionalLayoutMarginsKey"
private var layoutMarginsKey: String = "layoutMarginsKey"
private var tagKey: String = "tagKey"
private var preservesSuperviewLayoutMarginsKey: String = "preservesSuperviewLayoutMarginsKey"
private var insetsLayoutMarginsFromSafeAreaKey: String = "insetsLayoutMarginsFromSafeAreaKey"
private var clipsToBoundsKey: String = "clipsToBoundsKey"
private var alphaKey: String = "alphaKey"
private var isOpaqueKey: String = "isOpaqueKey"
private var clearsContextBeforeDrawingKey: String = "clearsContextBeforeDrawingKey"
private var isHiddenKey: String = "isHiddenKey"
private var backgroundColorKey: String = "backgroundColorKey"
private var maskKey: String = "maskKey"
private var tintColorKey: String = "tintColorKey"
// swiftlint:disable:next identifier_name
private var translatesAutoresizingMaskIntoConstraintsKey: String = "translatesAutoresizingMaskIntoConstraintsKey"
private var restorationIdentifierKey: String = "restorationIdentifierKey"

public extension BindableCollection where Object: UIView {
    
    // MARK: Two Way Relay

    var isUserInteractionEnabled: Observable<Bool> {
        bindable(of: \.isUserInteractionEnabled, key: &isUserInteractionEnabledKey)
    }
    
    var tag: Observable<Int> {
        bindable(of: \.tag, key: &tagKey)
    }
    
    @available(iOS 14.0, *)
    var focusGroupIdentifier: Observable<String?> {
        bindable(of: \.focusGroupIdentifier, key: &focusGroupIdentifierKey)
    }
    
    var frame: Observable<CGRect> {
        bindable(of: \.frame, key: &frameKey)
    }
    
    var bounds: Observable<CGRect> {
        bindable(of: \.bounds, key: &boundsKey)
    }
    
    var center: Observable<CGPoint> {
        bindable(of: \.center, key: &centerKey)
    }
    
    var contentScaleFactor: Observable<CGFloat> {
        bindable(of: \.contentScaleFactor, key: &contentScaleFactorKey)
    }
    
    var isMultipleTouchEnabled: Observable<Bool> {
        bindable(of: \.isMultipleTouchEnabled, key: &isMultipleTouchEnabledKey)
    }
    
    var isExclusiveTouch: Observable<Bool> {
        bindable(of: \.isExclusiveTouch, key: &isExclusiveTouchKey)
    }

    var autoresizesSubviews: Observable<Bool> {
        bindable(of: \.autoresizesSubviews, key: &autoresizesSubviewsKey)
    }
    
    var layoutMargins: Observable<UIEdgeInsets> {
        bindable(of: \.layoutMargins, key: &layoutMarginsKey)
    }
    
    @available(iOS 11.0, *)
    var directionalLayoutMargins: Observable<NSDirectionalEdgeInsets> {
        bindable(of: \.directionalLayoutMargins, key: &directionalLayoutMarginsKey)
    }
    
    var preservesSuperviewLayoutMargins: Observable<Bool> {
        bindable(of: \.preservesSuperviewLayoutMargins, key: &preservesSuperviewLayoutMarginsKey)
    }
    
    @available(iOS 11.0, *)
    var insetsLayoutMarginsFromSafeArea: Observable<Bool> {
        bindable(of: \.insetsLayoutMarginsFromSafeArea, key: &insetsLayoutMarginsFromSafeAreaKey)
    }
    
    var clipsToBounds: Observable<Bool> {
        bindable(of: \.clipsToBounds, key: &clipsToBoundsKey)
    }
    
    var backgroundColor: Observable<UIColor?> {
        bindable(of: \.backgroundColor, key: &backgroundColorKey)
    }
    
    var alpha: Observable<CGFloat> {
        bindable(of: \.alpha, key: &alphaKey)
    }
    
    var isOpaque: Observable<Bool> {
        bindable(of: \.isOpaque, key: &isOpaqueKey)
    }
    
    var clearsContextBeforeDrawing: Observable<Bool> {
        bindable(of: \.clearsContextBeforeDrawing, key: &clearsContextBeforeDrawingKey)
    }
    
    var isHidden: Observable<Bool> {
        bindable(of: \.isHidden, key: &isHiddenKey)
    }
    
    var mask: Observable<UIView?> {
        bindable(of: \.mask, key: &maskKey)
    }
    
    var tintColor: Observable<UIColor?> {
        bindable(of: \.tintColor, key: &tintColorKey)
    }
    
    // swiftlint:disable:next identifier_name
    var translatesAutoresizingMaskIntoConstraints: Observable<Bool> {
        bindable(of: \.translatesAutoresizingMaskIntoConstraints, key: &translatesAutoresizingMaskIntoConstraintsKey)
    }
    
    var restorationIdentifier: Observable<String?> {
        bindable(of: \.restorationIdentifier, key: &restorationIdentifierKey)
    }
    
}
#endif
