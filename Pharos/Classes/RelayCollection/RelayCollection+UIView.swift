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

    var isUserInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isUserInteractionEnabled)
    }
    
    var tag: AssociativeTwoWayRelay<Int> {
        .relay(of: object, \.tag)
    }
    
    @available(iOS 14.0, *)
    var focusGroupIdentifier: AssociativeTwoWayRelay<String?> {
        .relay(of: object, \.focusGroupIdentifier)
    }
    
    var frame: AssociativeTwoWayRelay<CGRect> {
        .relay(of: object, \.frame)
    }
    
    var bounds: AssociativeTwoWayRelay<CGRect> {
        .relay(of: object, \.bounds)
    }
    
    var center: AssociativeTwoWayRelay<CGPoint> {
        .relay(of: object, \.center)
    }
    
    var contentScaleFactor: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.contentScaleFactor)
    }
    
    var isMultipleTouchEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isMultipleTouchEnabled)
    }
    
    var isExclusiveTouch: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isExclusiveTouch)
    }

    var autoresizesSubviews: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.autoresizesSubviews)
    }
    
    var layoutMargins: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.layoutMargins)
    }
    
    @available(iOS 11.0, *)
    var directionalLayoutMargins: AssociativeTwoWayRelay<NSDirectionalEdgeInsets> {
        .relay(of: object, \.directionalLayoutMargins)
    }
    
    var preservesSuperviewLayoutMargins: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.preservesSuperviewLayoutMargins)
    }
    
    @available(iOS 11.0, *)
    var insetsLayoutMarginsFromSafeArea: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.insetsLayoutMarginsFromSafeArea)
    }
    
    var clipsToBounds: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.clipsToBounds)
    }
    
    var backgroundColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.backgroundColor)
    }
    
    var alpha: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.alpha)
    }
    
    var isOpaque: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isOpaque)
    }
    
    var clearsContextBeforeDrawing: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.clearsContextBeforeDrawing)
    }
    
    var isHidden: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isHidden)
    }
    
    var mask: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.mask)
    }
    
    var tintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.tintColor)
    }
    
    var translatesAutoresizingMaskIntoConstraints: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.translatesAutoresizingMaskIntoConstraints)
    }
    
    var restorationIdentifier: AssociativeTwoWayRelay<String?> {
        .relay(of: object, \.restorationIdentifier)
    }
    
}
#endif
