//
//  TwoWayKVORelayTester.swift
//  Pharos_Tests
//
//  Created by Nayanda Haberty on 13/06/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Pharos
#if canImport(UIKit)
import UIKit

func testRelay<Object: NSObject, Property>(
    for object: Object,
    relay: TwoWayRelay<Property>,
    keyPath: ReferenceWritableKeyPath<Object, Property>,
    with newValue: Property,
    test: (Changes<Property>, Property) -> Void) {
    let retainer: Retainer = Retainer()
    defer {
        retainer.discardAll()
    }
    let oldValue = object[keyPath: keyPath]
    var changes: Changes<Property>? = nil
    waitUntil { done in
        relay.retained(by: retainer)
            .syncWhenInSameThread()
            .whenDidSet { change in
                changes = change
                done()
            }
        object[keyPath: keyPath] = newValue
    }
    guard let changes = changes else {
        fail("Relay of \(relay) not triggered")
        return
    }
    test(changes, oldValue)
}

func testRelay<Object: NSObject, Property: Equatable>(
    for object: Object,
    relay: TwoWayRelay<Property>,
    keyPath: ReferenceWritableKeyPath<Object, Property>,
    with newValue: Property) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<Bool>,
    keyPath: ReferenceWritableKeyPath<Object, Bool>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: Bool.random()
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<NSTextAlignment>,
    keyPath: ReferenceWritableKeyPath<Object, NSTextAlignment>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: .justified
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UITextField.BorderStyle>,
    keyPath: ReferenceWritableKeyPath<Object, UITextField.BorderStyle>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: .bezel
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<NSRange>,
    keyPath: ReferenceWritableKeyPath<Object, NSRange>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: NSRange(location: 0, length: 0)
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UIDataDetectorTypes>,
    keyPath: ReferenceWritableKeyPath<Object, UIDataDetectorTypes>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: .address
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<NSAttributedString>,
    keyPath: ReferenceWritableKeyPath<Object, NSAttributedString>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: NSAttributedString(string: "test")) { changes, oldValue in
        expect(changes.new.string).to(equal("test"))
        expect(changes.old.string).to(equal(oldValue.string))
    }
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<NSAttributedString?>,
    keyPath: ReferenceWritableKeyPath<Object, NSAttributedString?>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: NSAttributedString(string: "test")) { changes, oldValue in
        expect(changes.new?.string).to(equal("test"))
        expect(changes.old?.string).to(equal(oldValue?.string))
    }
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UIFont?>,
    keyPath: ReferenceWritableKeyPath<Object, UIFont?>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: UIFont.systemFont(ofSize: 123, weight: .medium)
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UITextField.ViewMode>,
    keyPath: ReferenceWritableKeyPath<Object, UITextField.ViewMode>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: .never
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UIImage?>,
    keyPath: ReferenceWritableKeyPath<Object, UIImage?>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: UIImage()
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<String?>,
    keyPath: ReferenceWritableKeyPath<Object, String?>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: "testing pharos"
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UIColor?>,
    keyPath: ReferenceWritableKeyPath<Object, UIColor?>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: .brown
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UIView?>,
    keyPath: ReferenceWritableKeyPath<Object, UIView?>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: UIView()
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<Int>,
    keyPath: ReferenceWritableKeyPath<Object, Int>) {
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: Int.random(in: -256..<256)
    )
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<CGFloat>,
    keyPath: ReferenceWritableKeyPath<Object, CGFloat>) {
    let newValue = CGFloat.random(in: -1024..<1024)
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
        expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
    }
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<CGRect>,
    keyPath: ReferenceWritableKeyPath<Object, CGRect>) {
    let newValue = CGRect(
        x: CGFloat.random(in: -1024..<1024),
        y: CGFloat.random(in: -1024..<1024),
        width: CGFloat.random(in: 0..<1024),
        height: CGFloat.random(in: 0..<1024)
    )
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.origin.x - newValue.origin.x)).to(beLessThan(0.0001))
        expect(abs(changes.new.origin.y - newValue.origin.y)).to(beLessThan(0.0001))
        expect(abs(changes.new.width - newValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.new.height - newValue.height)).to(beLessThan(0.0001))
        expect(abs(changes.old.origin.x - oldValue.origin.x)).to(beLessThan(0.0001))
        expect(abs(changes.old.origin.y - oldValue.origin.y)).to(beLessThan(0.0001))
        expect(abs(changes.old.width - oldValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.old.height - oldValue.height)).to(beLessThan(0.0001))
    }
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<CGPoint>,
    keyPath: ReferenceWritableKeyPath<Object, CGPoint>) {
    let newValue = CGPoint(
        x: CGFloat.random(in: -1024..<1024),
        y: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.x - newValue.x)).to(beLessThan(0.0001))
        expect(abs(changes.new.y - newValue.y)).to(beLessThan(0.0001))
        expect(abs(changes.old.x - oldValue.x)).to(beLessThan(0.0001))
        expect(abs(changes.old.y - oldValue.y)).to(beLessThan(0.0001))
    }
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<CGSize>,
    keyPath: ReferenceWritableKeyPath<Object, CGSize>) {
    let newValue = CGSize(
        width: CGFloat.random(in: 0..<1024),
        height: CGFloat.random(in: 0..<1024)
    )
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.width - newValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.new.height - newValue.height)).to(beLessThan(0.0001))
        expect(abs(changes.old.width - oldValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.old.height - oldValue.height)).to(beLessThan(0.0001))
    }
}

func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<UIEdgeInsets>,
    keyPath: ReferenceWritableKeyPath<Object, UIEdgeInsets>) {
    let newValue = UIEdgeInsets(
        top: CGFloat.random(in: -1024..<1024),
        left: CGFloat.random(in: -1024..<1024),
        bottom: CGFloat.random(in: -1024..<1024),
        right: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.top - newValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.new.left - newValue.left)).to(beLessThan(0.0001))
        expect(abs(changes.new.bottom - newValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.new.right - newValue.right)).to(beLessThan(0.0001))
        expect(abs(changes.old.top - oldValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.old.left - oldValue.left)).to(beLessThan(0.0001))
        expect(abs(changes.old.bottom - oldValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.old.right - oldValue.right)).to(beLessThan(0.0001))
    }
}

@available(iOS 11.0, *)
func testRelay<Object: NSObject>(
    for object: Object,
    relay: TwoWayRelay<NSDirectionalEdgeInsets>,
    keyPath: ReferenceWritableKeyPath<Object, NSDirectionalEdgeInsets>) {
    let newValue = NSDirectionalEdgeInsets(
        top: CGFloat.random(in: -1024..<1024),
        leading: CGFloat.random(in: -1024..<1024),
        bottom: CGFloat.random(in: -1024..<1024),
        trailing: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: object,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.top - newValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.new.leading - newValue.leading)).to(beLessThan(0.0001))
        expect(abs(changes.new.bottom - newValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.new.trailing - newValue.trailing)).to(beLessThan(0.0001))
        expect(abs(changes.old.top - oldValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.old.leading - oldValue.leading)).to(beLessThan(0.0001))
        expect(abs(changes.old.bottom - oldValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.old.trailing - oldValue.trailing)).to(beLessThan(0.0001))
    }
}
#endif
