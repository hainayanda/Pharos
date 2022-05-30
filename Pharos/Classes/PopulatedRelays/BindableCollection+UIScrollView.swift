//
//  RelayCollection+Scroll.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var contentOffsetKey: String = "contentOffsetKey"
fileprivate var contentSizeKey: String = "contentSizeKey"
fileprivate var contentInsetKey: String = "contentInsetKey"
fileprivate var isDirectionalLockEnabledKey: String = "isDirectionalLockEnabledKey"
fileprivate var bouncesKey: String = "bouncesKey"
fileprivate var alwaysBounceVerticalKey: String = "alwaysBounceVerticalKey"
fileprivate var preferredMaxLayoutWidthKey: String = "preferredMaxLayoutWidthKey"
fileprivate var delegateKey: String = "delegateKey"
fileprivate var isPagingEnabledKey: String = "isPagingEnabledKey"
fileprivate var alwaysBounceHorizontalKey: String = "alwaysBounceHorizontalKey"
fileprivate var isScrollEnabledKey: String = "isScrollEnabledKey"
fileprivate var showsVerticalScrollIndicatorKey: String = "showsVerticalScrollIndicatorKey"
fileprivate var showsHorizontalScrollIndicatorKey: String = "showsHorizontalScrollIndicatorKey"
fileprivate var verticalScrollIndicatorInsetsKey: String = "verticalScrollIndicatorInsetsKey"
fileprivate var horizontalScrollIndicatorInsetsKey: String = "horizontalScrollIndicatorInsetsKey"
fileprivate var scrollIndicatorInsetsKey: String = "scrollIndicatorInsetsKey"
fileprivate var delaysContentTouchesKey: String = "delaysContentTouchesKey"
fileprivate var canCancelContentTouchesKey: String = "canCancelContentTouchesKey"
fileprivate var minimumZoomScaleKey: String = "minimumZoomScaleKey"
fileprivate var zoomScaleKey: String = "zoomScaleKey"
fileprivate var maximumZoomScaleKey: String = "maximumZoomScaleKey"
fileprivate var bouncesZoomKey: String = "bouncesZoomKey"
fileprivate var scrollsToTopKey: String = "scrollsToTopKey"
fileprivate var refreshControlKey: String = "refreshControlKey"

public extension BindableCollection where Object: UIScrollView {
    
    // MARK: Two Way Relay
    
    var contentOffset: BindableObservable<CGPoint> {
        bindable(of: \.contentOffset, key: &contentOffsetKey)
    }
    
    var contentSize: BindableObservable<CGSize> {
        bindable(of: \.contentSize, key: &contentSizeKey)
    }
    
    var contentInset: BindableObservable<UIEdgeInsets> {
        bindable(of: \.contentInset, key: &contentInsetKey)
    }
    
    var delegate: BindableObservable<UIScrollViewDelegate?> {
        bindable(of: \.delegate, key: &delegateKey)
    }
    
    var isDirectionalLockEnabled: BindableObservable<Bool> {
        bindable(of: \.isDirectionalLockEnabled, key: &isDirectionalLockEnabledKey)
    }
    
    var bounces: BindableObservable<Bool> {
        bindable(of: \.bounces, key: &bouncesKey)
    }
    
    var alwaysBounceVertical: BindableObservable<Bool> {
        bindable(of: \.alwaysBounceVertical, key: &alwaysBounceVerticalKey)
    }
    
    var alwaysBounceHorizontal: BindableObservable<Bool> {
        bindable(of: \.alwaysBounceHorizontal, key: &alwaysBounceHorizontalKey)
    }
    
    var isPagingEnabled: BindableObservable<Bool> {
        bindable(of: \.isPagingEnabled, key: &isPagingEnabledKey)
    }
    
    var isScrollEnabled: BindableObservable<Bool> {
        bindable(of: \.isScrollEnabled, key: &isScrollEnabledKey)
    }
    
    var showsVerticalScrollIndicator: BindableObservable<Bool> {
        bindable(of: \.showsVerticalScrollIndicator, key: &showsVerticalScrollIndicatorKey)
    }
    
    var showsHorizontalScrollIndicator: BindableObservable<Bool> {
        bindable(of: \.showsHorizontalScrollIndicator, key: &showsHorizontalScrollIndicatorKey)
    }
    
    @available(iOS 11.1, *)
    var verticalScrollIndicatorInsets: BindableObservable<UIEdgeInsets> {
        bindable(of: \.verticalScrollIndicatorInsets, key: &verticalScrollIndicatorInsetsKey)
    }
    
    @available(iOS 11.1, *)
    var horizontalScrollIndicatorInsets: BindableObservable<UIEdgeInsets> {
        bindable(of: \.horizontalScrollIndicatorInsets, key: &horizontalScrollIndicatorInsetsKey)
    }
    
    var scrollIndicatorInsets: BindableObservable<UIEdgeInsets> {
        bindable(of: \.scrollIndicatorInsets, key: &scrollIndicatorInsetsKey)
    }
    
    var delaysContentTouches: BindableObservable<Bool> {
        bindable(of: \.delaysContentTouches, key: &delaysContentTouchesKey)
    }
    
    var canCancelContentTouches: BindableObservable<Bool> {
        bindable(of: \.canCancelContentTouches, key: &canCancelContentTouchesKey)
    }
    
    var minimumZoomScale: BindableObservable<CGFloat> {
        bindable(of: \.minimumZoomScale, key: &minimumZoomScaleKey)
    }
    
    var maximumZoomScale: BindableObservable<CGFloat> {
        bindable(of: \.maximumZoomScale, key: &maximumZoomScaleKey)
    }
    
    var zoomScale: BindableObservable<CGFloat> {
        bindable(of: \.zoomScale, key: &zoomScaleKey)
    }
    
    var bouncesZoom: BindableObservable<Bool> {
        bindable(of: \.bouncesZoom, key: &bouncesZoomKey)
    }
    
    var scrollsToTop: BindableObservable<Bool> {
        bindable(of: \.scrollsToTop, key: &scrollsToTopKey)
    }
    
    var refreshControl: BindableObservable<UIRefreshControl?> {
        bindable(of: \.refreshControl, key: &refreshControlKey)
    }
    
}
#endif
