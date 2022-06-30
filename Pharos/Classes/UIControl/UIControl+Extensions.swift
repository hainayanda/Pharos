//
//  UIControl+Extensions.swift
//  Pharos
//
//  Created by Nayanda Haberty on 30/06/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

var controlActionAssociatedKey: String = "controlActionAssociatedKey"

extension UIControl.Event: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}

extension UIControl {
    
    var allEventsPair: [UIControl.Event: Selector] {
        if #available(iOS 14.0, *) {
            return [
                .touchDown: #selector(UIControlAction.touchDown(by:)),
                .touchDownRepeat: #selector(UIControlAction.touchDownRepeat(by:)),
                .touchDragInside: #selector(UIControlAction.touchDragInside(by:)),
                .touchDragOutside: #selector(UIControlAction.touchDragOutside(by:)),
                .touchDragEnter: #selector(UIControlAction.touchDragEnter(by:)),
                .touchDragExit: #selector(UIControlAction.touchDragExit(by:)),
                .touchUpInside: #selector(UIControlAction.touchUpInside(by:)),
                .touchUpOutside: #selector(UIControlAction.touchUpOutside(by:)),
                .touchCancel: #selector(UIControlAction.touchCancel(by:)),
                .valueChanged: #selector(UIControlAction.valueChanged(by:)),
                .primaryActionTriggered: #selector(UIControlAction.primaryActionTriggered(by:)),
                .menuActionTriggered: #selector(UIControlAction.menuActionTriggered(by:)),
                .editingDidBegin: #selector(UIControlAction.editingDidBegin(by:)),
                .editingChanged: #selector(UIControlAction.editingChanged(by:)),
                .editingDidEnd: #selector(UIControlAction.editingDidEnd(by:)),
                .editingDidEndOnExit: #selector(UIControlAction.editingDidEndOnExit(by:))
            ]
        } else {
            return [
                .touchDown: #selector(UIControlAction.touchDown(by:)),
                .touchDownRepeat: #selector(UIControlAction.touchDownRepeat(by:)),
                .touchDragInside: #selector(UIControlAction.touchDragInside(by:)),
                .touchDragOutside: #selector(UIControlAction.touchDragOutside(by:)),
                .touchDragEnter: #selector(UIControlAction.touchDragEnter(by:)),
                .touchDragExit: #selector(UIControlAction.touchDragExit(by:)),
                .touchUpInside: #selector(UIControlAction.touchUpInside(by:)),
                .touchUpOutside: #selector(UIControlAction.touchUpOutside(by:)),
                .touchCancel: #selector(UIControlAction.touchCancel(by:)),
                .valueChanged: #selector(UIControlAction.valueChanged(by:)),
                .primaryActionTriggered: #selector(UIControlAction.primaryActionTriggered(by:)),
                .editingDidBegin: #selector(UIControlAction.editingDidBegin(by:)),
                .editingChanged: #selector(UIControlAction.editingChanged(by:)),
                .editingDidEnd: #selector(UIControlAction.editingDidEnd(by:)),
                .editingDidEndOnExit: #selector(UIControlAction.editingDidEndOnExit(by:))
            ]
        }
    }
    
    var allEvents: [UIControl.Event] {
        if #available(iOS 14.0, *) {
            return [
                .touchDown,
                .touchDownRepeat,
                .touchDragInside,
                .touchDragOutside,
                .touchDragEnter,
                .touchDragExit,
                .touchUpInside,
                .touchUpOutside,
                .touchCancel,
                .valueChanged,
                .primaryActionTriggered,
                .menuActionTriggered,
                .editingDidBegin,
                .editingChanged,
                .editingDidEnd,
                .editingDidEndOnExit
            ]
        } else {
            return [
                .touchDown,
                .touchDownRepeat,
                .touchDragInside,
                .touchDragOutside,
                .touchDragEnter,
                .touchDragExit,
                .touchUpInside,
                .touchUpOutside,
                .touchCancel,
                .valueChanged,
                .primaryActionTriggered,
                .editingDidBegin,
                .editingChanged,
                .editingDidEnd,
                .editingDidEndOnExit
            ]
        }
    }
    
    var allTouchEvents: [UIControl.Event] {
        [
            .touchDown,
            .touchDownRepeat,
            .touchDragInside,
            .touchDragOutside,
            .touchDragEnter,
            .touchDragExit,
            .touchUpInside,
            .touchUpOutside,
            .touchCancel
        ]
    }
    
    var allEditingEvents: [UIControl.Event] {
        [
            .editingDidBegin,
            .editingChanged,
            .editingDidEnd,
            .editingDidEndOnExit
        ]
    }
}

extension UIControl {
    
    public func whenDetectEvent(thenDo work: @escaping (Changes<UIControl.Event>) -> Void) -> Observed<UIControl.Event> {
        getControlAction().eventObservable.whenDidSet(thenDo: work)
    }
    
    public func whenDidTriggered(by event: UIControl.Event, thenDo work: @escaping (Changes<UIControl.Event>) -> Void) -> Observed<UIControl.Event> {
        let eventUsed: [UIControl.Event]
        if event == .allEvents {
            eventUsed = allEvents
        } else if event == .allTouchEvents {
            eventUsed = allTouchEvents
        } else if event == .allEditingEvents {
            eventUsed = allEditingEvents
        } else {
            eventUsed = [event]
        }
        return getControlAction().eventObservable.onlyInclude {
            eventUsed.contains($0.new)
        }.whenDidSet(thenDo: work)
    }
    
    public func whenDidTapped(thenDo work: @escaping (Changes<UIControl.Event>) -> Void) -> Observed<UIControl.Event> {
        whenDidTriggered(by: .touchUpInside, thenDo: work)
    }
    
    func getControlAction() -> UIControlAction {
        guard let controlAction = objc_getAssociatedObject(self, &controlActionAssociatedKey) as? UIControlAction else {
            let controlAction = UIControlAction()
            let allPairs = allEventsPair
            for event in allEvents {
                guard let selector = allPairs[event] else { continue }
                addTarget(controlAction, action: selector, for: event)
            }
            objc_setAssociatedObject(self, &controlActionAssociatedKey, controlAction, .OBJC_ASSOCIATION_RETAIN)
            return controlAction
        }
        return controlAction
    }
}

#endif
