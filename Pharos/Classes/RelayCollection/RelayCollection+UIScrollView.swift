//
//  RelayCollection+Scroll.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIScrollView {
    var scrollRelays: RelayCollection<UIScrollView> {
        .init(object: self)
    }
}

public extension RelayCollection where Object: UIScrollView {
    
    // MARK: Two Way Relay
    
    var contentOffset: TwoWayRelay<CGPoint> {
        .relay(of: object, \.contentOffset)
    }
    
    var contentSize: TwoWayRelay<CGSize> {
        .relay(of: object, \.contentSize)
    }
    
    var contentInset: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.contentInset)
    }
    
    @available(iOS 11.0, *)
    var contentInsetAdjustmentBehavior: TwoWayRelay<UIScrollView.ContentInsetAdjustmentBehavior> {
        .relay(of: object, \.contentInsetAdjustmentBehavior)
    }
    
    @available(iOS 13.0, *)
    var automaticallyAdjustsScrollIndicatorInsets: TwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyAdjustsScrollIndicatorInsets)
    }
    
    var delegate: TwoWayRelay<UIScrollViewDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var isDirectionalLockEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isDirectionalLockEnabled)
    }
    
    var bounces: TwoWayRelay<Bool> {
        .relay(of: object, \.bounces)
    }
    
    var alwaysBounceVertical: TwoWayRelay<Bool> {
        .relay(of: object, \.alwaysBounceVertical)
    }
    
    var alwaysBounceHorizontal: TwoWayRelay<Bool> {
        .relay(of: object, \.alwaysBounceHorizontal)
    }
    
    var isPagingEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isPagingEnabled)
    }
    
    var isScrollEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isScrollEnabled)
    }
    
    var showsVerticalScrollIndicator: TwoWayRelay<Bool> {
        .relay(of: object, \.showsVerticalScrollIndicator)
    }
    
    var showsHorizontalScrollIndicator: TwoWayRelay<Bool> {
        .relay(of: object, \.showsHorizontalScrollIndicator)
    }
    
    var indicatorStyle: TwoWayRelay<UIScrollView.IndicatorStyle> {
        .relay(of: object, \.indicatorStyle)
    }
    
    @available(iOS 11.1, *)
    var verticalScrollIndicatorInsets: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.verticalScrollIndicatorInsets)
    }
    
    @available(iOS 11.1, *)
    var horizontalScrollIndicatorInsets: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.horizontalScrollIndicatorInsets)
    }
    
    var scrollIndicatorInsets: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.scrollIndicatorInsets)
    }
    
    var decelerationRate: TwoWayRelay<UIScrollView.DecelerationRate> {
        .relay(of: object, \.decelerationRate)
    }

    var indexDisplayMode: TwoWayRelay<UIScrollView.IndexDisplayMode> {
        .relay(of: object, \.indexDisplayMode)
    }
    
    var delaysContentTouches: TwoWayRelay<Bool> {
        .relay(of: object, \.delaysContentTouches)
    }
    
    var canCancelContentTouches: TwoWayRelay<Bool> {
        .relay(of: object, \.canCancelContentTouches)
    }
    
    var minimumZoomScale: TwoWayRelay<CGFloat> {
        .relay(of: object, \.minimumZoomScale)
    }
    
    var maximumZoomScale: TwoWayRelay<CGFloat> {
        .relay(of: object, \.maximumZoomScale)
    }
    
    var zoomScale: TwoWayRelay<CGFloat> {
        .relay(of: object, \.zoomScale)
    }
    
    var bouncesZoom: TwoWayRelay<Bool> {
        .relay(of: object, \.bouncesZoom)
    }
    
    var scrollsToTop: TwoWayRelay<Bool> {
        .relay(of: object, \.scrollsToTop)
    }
    
    var keyboardDismissMode: TwoWayRelay<UIScrollView.KeyboardDismissMode> {
        .relay(of: object, \.keyboardDismissMode)
    }
    
    var refreshControl: TwoWayRelay<UIRefreshControl?> {
        .relay(of: object, \.refreshControl)
    }
    
    // MARK: Value Relay
    
    @available(iOS 11.0, *)
    var adjustedContentInset: ValueRelay<UIEdgeInsets> {
        .relay(of: object, \.adjustedContentInset)
    }
    
    @available(iOS 11.0, *)
    var contentLayoutGuide: ValueRelay<UILayoutGuide> {
        .relay(of: object, \.contentLayoutGuide)
    }
    
    @available(iOS 11.0, *)
    var frameLayoutGuide: ValueRelay<UILayoutGuide> {
        .relay(of: object, \.frameLayoutGuide)
    }
    
    var isTracking: ValueRelay<Bool> {
        .relay(of: object, \.isTracking)
    }
    
    var isDragging: ValueRelay<Bool> {
        .relay(of: object, \.isDragging)
    }
    
    var isDecelerating: ValueRelay<Bool> {
        .relay(of: object, \.isDecelerating)
    }
    
    var isZooming: ValueRelay<Bool> {
        .relay(of: object, \.isZooming)
    }
    
    var isZoomBouncing: ValueRelay<Bool> {
        .relay(of: object, \.isZoomBouncing)
    }
    
    var panGestureRecognizer: ValueRelay<UIPanGestureRecognizer> {
        .relay(of: object, \.panGestureRecognizer)
    }
    
    var pinchGestureRecognizer: ValueRelay<UIPinchGestureRecognizer?> {
        .relay(of: object, \.pinchGestureRecognizer)
    }
    
    var directionalPressGestureRecognizer: ValueRelay<UIGestureRecognizer> {
        .relay(of: object, \.directionalPressGestureRecognizer)
    }
    
}
#endif
