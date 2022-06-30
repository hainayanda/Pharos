//
//  UIControlAction.swift
//  Pharos
//
//  Created by Nayanda Haberty on 30/06/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

class UIControlAction: NSObject {
    @UIControlSubject var lastEvent: UIControl.Event = .allEvents
    
    var eventObservable: Observable<UIControl.Event> {
        $lastEvent
    }
    
    func invoked(by sender: UIControl, with event: UIControl.Event) {
        _lastEvent.sender = sender
        self.lastEvent = event
    }
    
    @objc func touchDown(by sender: UIControl) {
        invoked(by: sender, with: .touchDown)
    }
    
    @objc func touchDownRepeat(by sender: UIControl) {
        invoked(by: sender, with: .touchDownRepeat)
    }
    
    @objc func touchDragInside(by sender: UIControl) {
        invoked(by: sender, with: .touchDragInside)
    }
    
    @objc func touchDragOutside(by sender: UIControl) {
        invoked(by: sender, with: .touchDragOutside)
    }
    
    @objc func touchDragEnter(by sender: UIControl) {
        invoked(by: sender, with: .touchDragEnter)
    }
    
    @objc func touchDragExit(by sender: UIControl) {
        invoked(by: sender, with: .touchDragExit)
    }
    
    @objc func touchUpInside(by sender: UIControl) {
        invoked(by: sender, with: .touchUpInside)
    }
    
    @objc func touchUpOutside(by sender: UIControl) {
        invoked(by: sender, with: .touchUpOutside)
    }
    
    @objc func touchCancel(by sender: UIControl) {
        invoked(by: sender, with: .touchCancel)
    }
    
    @objc func valueChanged(by sender: UIControl) {
        invoked(by: sender, with: .valueChanged)
    }
    
    @objc func primaryActionTriggered(by sender: UIControl) {
        invoked(by: sender, with: .primaryActionTriggered)
    }
    
    @available(iOS 14.0, *)
    @objc func menuActionTriggered(by sender: UIControl) {
        invoked(by: sender, with: .menuActionTriggered)
    }
    
    @objc func editingDidBegin(by sender: UIControl) {
        invoked(by: sender, with: .editingDidBegin)
    }
    
    @objc func editingChanged(by sender: UIControl) {
        invoked(by: sender, with: .editingChanged)
    }
    
    @objc func editingDidEnd(by sender: UIControl) {
        invoked(by: sender, with: .editingDidEnd)
    }
    
    @objc func editingDidEndOnExit(by sender: UIControl) {
        invoked(by: sender, with: .editingDidEndOnExit)
    }
}
#endif
