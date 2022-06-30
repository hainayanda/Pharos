//
//  UIControlRelayCollectionSpec.swift
//  Pharos_Tests
//
//  Created by Nayanda Haberty on 19/06/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Pharos
#if canImport(UIKit)
import UIKit

class UIControlRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIControlRelayCollection") {
            var view: UIControl!
            beforeEach {
                view = UIControl()
            }
            it("should relay isEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isEnabled,
                    keyPath: \.isEnabled
                )
            }
            it("should relay isSelected") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isSelected,
                    keyPath: \.isSelected
                )
            }
            it("should relay isHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
            it("should trigerred by event") {
                var eventCount: Int = 0
                var lastEvent: UIControl.Event?
                view.whenDetectEvent {
                    lastEvent = $0.new
                    eventCount += 1
                }.retain()
                for (offset, event) in uiControlEvents.enumerated() {
                    view.simulateEvent(event)
                    expect(lastEvent).to(equal(event))
                    expect(eventCount).to(equal(offset + 1))
                }
            }
            it("should trigerred by tap") {
                var eventCount: Int = 0
                var lastEvent: UIControl.Event?
                view.whenDidTapped {
                    lastEvent = $0.new
                    eventCount += 1
                }.retain()
                for event in uiControlEvents {
                    view.simulateEvent(event)
                    if event == .touchUpInside {
                        expect(lastEvent).to(equal(.touchUpInside))
                        expect(eventCount).to(equal(1))
                    }
                }
                expect(eventCount).to(equal(1))
            }
        }
    }
}

var uiControlEvents: [UIControl.Event] = [
    .touchDown, .touchDownRepeat, .touchDragInside,
    .touchDragOutside, .touchDragEnter, .touchDragExit,
    .touchUpInside, .touchUpOutside, .touchCancel,
    .valueChanged, .primaryActionTriggered, .editingDidBegin,
    .editingChanged, .editingDidEnd, .editingDidEndOnExit
]

extension UIControl {
    
    func simulateEvent(_ event: UIControl.Event) {
        for target in allTargets {
            let target = target as NSObjectProtocol
            for actionName in actions(forTarget: target, forControlEvent: event) ?? [] {
                let selector = Selector(actionName)
                target.perform(selector, with: self, with: event)
            }
        }
    }
}
#endif
