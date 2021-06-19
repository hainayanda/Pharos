//
//  RelayCollection+Scroll.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIScrollView {
    
    // MARK: Two Way Relay
    
    var contentOffset: AssociativeTwoWayRelay<CGPoint> {
        .relay(of: object, \.contentOffset)
    }
    
    var contentSize: AssociativeTwoWayRelay<CGSize> {
        .relay(of: object, \.contentSize)
    }
    
    var contentInset: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.contentInset)
    }
    
    var delegate: AssociativeTwoWayRelay<UIScrollViewDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var isDirectionalLockEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isDirectionalLockEnabled)
    }
    
    var bounces: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.bounces)
    }
    
    var alwaysBounceVertical: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.alwaysBounceVertical)
    }
    
    var alwaysBounceHorizontal: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.alwaysBounceHorizontal)
    }
    
    var isPagingEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isPagingEnabled)
    }
    
    var isScrollEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isScrollEnabled)
    }
    
    var showsVerticalScrollIndicator: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.showsVerticalScrollIndicator)
    }
    
    var showsHorizontalScrollIndicator: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.showsHorizontalScrollIndicator)
    }
    
    @available(iOS 11.1, *)
    var verticalScrollIndicatorInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.verticalScrollIndicatorInsets)
    }
    
    @available(iOS 11.1, *)
    var horizontalScrollIndicatorInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.horizontalScrollIndicatorInsets)
    }
    
    var scrollIndicatorInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.scrollIndicatorInsets)
    }
    
    var delaysContentTouches: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.delaysContentTouches)
    }
    
    var canCancelContentTouches: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.canCancelContentTouches)
    }
    
    var minimumZoomScale: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.minimumZoomScale)
    }
    
    var maximumZoomScale: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.maximumZoomScale)
    }
    
    var zoomScale: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.zoomScale)
    }
    
    var bouncesZoom: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.bouncesZoom)
    }
    
    var scrollsToTop: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.scrollsToTop)
    }
    
    var refreshControl: AssociativeTwoWayRelay<UIRefreshControl?> {
        .relay(of: object, \.refreshControl)
    }
    
}
#endif
