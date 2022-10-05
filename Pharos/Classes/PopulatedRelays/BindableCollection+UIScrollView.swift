//
//  RelayCollection+Scroll.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var contentOffsetKey: String = "contentOffsetKey"
private var contentSizeKey: String = "contentSizeKey"
private var contentInsetKey: String = "contentInsetKey"
private var isDirectionalLockEnabledKey: String = "isDirectionalLockEnabledKey"
private var bouncesKey: String = "bouncesKey"
private var alwaysBounceVerticalKey: String = "alwaysBounceVerticalKey"
private var preferredMaxLayoutWidthKey: String = "preferredMaxLayoutWidthKey"
private var delegateKey: String = "delegateKey"
private var isPagingEnabledKey: String = "isPagingEnabledKey"
private var alwaysBounceHorizontalKey: String = "alwaysBounceHorizontalKey"
private var isScrollEnabledKey: String = "isScrollEnabledKey"
private var showsVerticalScrollIndicatorKey: String = "showsVerticalScrollIndicatorKey"
private var showsHorizontalScrollIndicatorKey: String = "showsHorizontalScrollIndicatorKey"
private var verticalScrollIndicatorInsetsKey: String = "verticalScrollIndicatorInsetsKey"
private var horizontalScrollIndicatorInsetsKey: String = "horizontalScrollIndicatorInsetsKey"
private var scrollIndicatorInsetsKey: String = "scrollIndicatorInsetsKey"
private var delaysContentTouchesKey: String = "delaysContentTouchesKey"
private var canCancelContentTouchesKey: String = "canCancelContentTouchesKey"
private var minimumZoomScaleKey: String = "minimumZoomScaleKey"
private var zoomScaleKey: String = "zoomScaleKey"
private var maximumZoomScaleKey: String = "maximumZoomScaleKey"
private var bouncesZoomKey: String = "bouncesZoomKey"
private var scrollsToTopKey: String = "scrollsToTopKey"
private var refreshControlKey: String = "refreshControlKey"

public extension BindableCollection where Object: UIScrollView {
    
    // MARK: Two Way Relay
    
    var contentOffset: Observable<CGPoint> {
        bindable(of: \.contentOffset, key: &contentOffsetKey)
    }
    
    var contentSize: Observable<CGSize> {
        bindable(of: \.contentSize, key: &contentSizeKey)
    }
    
    var contentInset: Observable<UIEdgeInsets> {
        bindable(of: \.contentInset, key: &contentInsetKey)
    }
    
    var delegate: Observable<UIScrollViewDelegate?> {
        bindable(of: \.delegate, key: &delegateKey)
    }
    
    var isDirectionalLockEnabled: Observable<Bool> {
        bindable(of: \.isDirectionalLockEnabled, key: &isDirectionalLockEnabledKey)
    }
    
    var bounces: Observable<Bool> {
        bindable(of: \.bounces, key: &bouncesKey)
    }
    
    var alwaysBounceVertical: Observable<Bool> {
        bindable(of: \.alwaysBounceVertical, key: &alwaysBounceVerticalKey)
    }
    
    var alwaysBounceHorizontal: Observable<Bool> {
        bindable(of: \.alwaysBounceHorizontal, key: &alwaysBounceHorizontalKey)
    }
    
    var isPagingEnabled: Observable<Bool> {
        bindable(of: \.isPagingEnabled, key: &isPagingEnabledKey)
    }
    
    var isScrollEnabled: Observable<Bool> {
        bindable(of: \.isScrollEnabled, key: &isScrollEnabledKey)
    }
    
    var showsVerticalScrollIndicator: Observable<Bool> {
        bindable(of: \.showsVerticalScrollIndicator, key: &showsVerticalScrollIndicatorKey)
    }
    
    var showsHorizontalScrollIndicator: Observable<Bool> {
        bindable(of: \.showsHorizontalScrollIndicator, key: &showsHorizontalScrollIndicatorKey)
    }
    
    @available(iOS 11.1, *)
    var verticalScrollIndicatorInsets: Observable<UIEdgeInsets> {
        bindable(of: \.verticalScrollIndicatorInsets, key: &verticalScrollIndicatorInsetsKey)
    }
    
    @available(iOS 11.1, *)
    var horizontalScrollIndicatorInsets: Observable<UIEdgeInsets> {
        bindable(of: \.horizontalScrollIndicatorInsets, key: &horizontalScrollIndicatorInsetsKey)
    }
    
    var scrollIndicatorInsets: Observable<UIEdgeInsets> {
        bindable(of: \.scrollIndicatorInsets, key: &scrollIndicatorInsetsKey)
    }
    
    var delaysContentTouches: Observable<Bool> {
        bindable(of: \.delaysContentTouches, key: &delaysContentTouchesKey)
    }
    
    var canCancelContentTouches: Observable<Bool> {
        bindable(of: \.canCancelContentTouches, key: &canCancelContentTouchesKey)
    }
    
    var minimumZoomScale: Observable<CGFloat> {
        bindable(of: \.minimumZoomScale, key: &minimumZoomScaleKey)
    }
    
    var maximumZoomScale: Observable<CGFloat> {
        bindable(of: \.maximumZoomScale, key: &maximumZoomScaleKey)
    }
    
    var zoomScale: Observable<CGFloat> {
        bindable(of: \.zoomScale, key: &zoomScaleKey)
    }
    
    var bouncesZoom: Observable<Bool> {
        bindable(of: \.bouncesZoom, key: &bouncesZoomKey)
    }
    
    var scrollsToTop: Observable<Bool> {
        bindable(of: \.scrollsToTop, key: &scrollsToTopKey)
    }
    
    var refreshControl: Observable<UIRefreshControl?> {
        bindable(of: \.refreshControl, key: &refreshControlKey)
    }
    
}
#endif
