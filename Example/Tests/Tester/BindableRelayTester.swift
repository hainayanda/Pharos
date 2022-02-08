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
    for underlyingObject: Object,
    relay: BindableObservable<Property>,
    keyPath: ReferenceWritableKeyPath<Object, Property>,
    with newValue: Property,
    test: @escaping (Changes<Property>, Property) -> Void) {
    let retainer: Retainer = Retainer()
    defer {
        retainer.discardAllRetained()
    }
    let oldValue: Property = underlyingObject[keyPath: keyPath]
    waitUntil { done in
        relay
            .whenDidSet { changes in
                test(changes, oldValue)
                done()
            }
            .retained(by: retainer)
        underlyingObject[keyPath: keyPath] = newValue
    }
    retainer.discardAllRetained()
}

func testBoolRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<Bool>,
    keyPath: ReferenceWritableKeyPath<Object, Bool>) {
    let newValue: Bool = .random()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
            expect(changes.old).to(equal(oldValue))
    }
}

func testBreakModeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSLineBreakMode>,
    keyPath: ReferenceWritableKeyPath<Object, NSLineBreakMode>) {
    let newValue: NSLineBreakMode = .byClipping
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testBaselineRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIBaselineAdjustment>,
    keyPath: ReferenceWritableKeyPath<Object, UIBaselineAdjustment>) {
    let newValue: UIBaselineAdjustment = .alignBaselines
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testLineBreakRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSParagraphStyle.LineBreakStrategy>,
    keyPath: ReferenceWritableKeyPath<Object, NSParagraphStyle.LineBreakStrategy>) {
    let newValue: NSParagraphStyle.LineBreakStrategy = .pushOut
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testArrayImageRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<[UIImage]?>,
    keyPath: ReferenceWritableKeyPath<Object, [UIImage]?>) {
    let newValue: [UIImage]? = [UIImage()]
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? [UIImage]).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testTextAlignementRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSTextAlignment>,
    keyPath: ReferenceWritableKeyPath<Object, NSTextAlignment>) {
    let newValue: NSTextAlignment = .justified
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testOffsetRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIOffset>,
    keyPath: ReferenceWritableKeyPath<Object, UIOffset>) {
    let newValue: UIOffset = .init(horizontal: 123, vertical: 456)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.horizontal - newValue.horizontal)).to(beLessThan(0.0001))
        expect(abs(changes.old?.horizontal - oldValue.horizontal)).to(beLessThan(0.0001))
        expect(abs(changes.new.vertical - newValue.vertical)).to(beLessThan(0.0001))
        expect(abs(changes.old?.vertical - oldValue.vertical)).to(beLessThan(0.0001))
    }
}

func testBorderStyleRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UITextField.BorderStyle>,
    keyPath: ReferenceWritableKeyPath<Object, UITextField.BorderStyle>) {
    let newValue: UITextField.BorderStyle = .bezel
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testRangeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSRange>,
    keyPath: ReferenceWritableKeyPath<Object, NSRange>) {
    let newValue: NSRange = NSRange(location: 0, length: 0)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testDataDetectorRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIDataDetectorTypes>,
    keyPath: ReferenceWritableKeyPath<Object, UIDataDetectorTypes>) {
    let newValue: UIDataDetectorTypes = .address
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testAttributedStringRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSAttributedString>,
    keyPath: ReferenceWritableKeyPath<Object, NSAttributedString>) {
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: NSAttributedString(string: "test")) { changes, oldValue in
        expect(changes.new.string).to(equal("test"))
        expect(changes.old?.string).to(equal(oldValue.string))
    }
}

func testOptAttributedStringRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSAttributedString?>,
    keyPath: ReferenceWritableKeyPath<Object, NSAttributedString?>) {
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: NSAttributedString(string: "test")) { changes, oldValue in
        expect(changes.new?.string).to(equal("test"))
        if oldValue?.string == nil {
            expect(changes.old??.string).to(beNil())
        } else {
            expect(changes.old??.string).to(equal(oldValue?.string))
        }
    }
}

func testFontRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIFont?>,
    keyPath: ReferenceWritableKeyPath<Object, UIFont?>) {
    let newValue: UIFont = UIFont.systemFont(ofSize: 123, weight: .medium)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? UIFont).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testViewModeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UITextField.ViewMode>,
    keyPath: ReferenceWritableKeyPath<Object, UITextField.ViewMode>) {
    let newValue: UITextField.ViewMode = .always
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testImageRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIImage?>,
    keyPath: ReferenceWritableKeyPath<Object, UIImage?>) {
    let newValue: UIImage = UIImage()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? UIImage).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testStringRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<String?>,
    keyPath: ReferenceWritableKeyPath<Object, String?>) {
    let newValue: String = "testing pharos"
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? String).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testColorRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIColor?>,
    keyPath: ReferenceWritableKeyPath<Object, UIColor?>) {
    let newValue: UIColor = .brown
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? UIColor).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testVisualEffectRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIVisualEffect?>,
    keyPath: ReferenceWritableKeyPath<Object, UIVisualEffect?>) {
    let newValue: UIVisualEffect = UIVisualEffect()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? UIVisualEffect).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testAxisRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSLayoutConstraint.Axis>,
    keyPath: ReferenceWritableKeyPath<Object, NSLayoutConstraint.Axis>) {
    let newValue: NSLayoutConstraint.Axis = .horizontal
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testDistributionRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIStackView.Distribution>,
    keyPath: ReferenceWritableKeyPath<Object, UIStackView.Distribution>) {
    let newValue: UIStackView.Distribution = .equalCentering
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testAlignmentRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIStackView.Alignment>,
    keyPath: ReferenceWritableKeyPath<Object, UIStackView.Alignment>) {
    let newValue: UIStackView.Alignment = .center
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testViewRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIView?>,
    keyPath: ReferenceWritableKeyPath<Object, UIView?>) {
    let newValue: UIView = UIView()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? UIView).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testRefreshRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIRefreshControl?>,
    keyPath: ReferenceWritableKeyPath<Object, UIRefreshControl?>) {
    let newValue: UIRefreshControl = UIRefreshControl()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        if oldValue == nil {
            expect(changes.old as? UIRefreshControl).to(beNil())
        } else {
            expect(changes.old).to(equal(oldValue))
        }
    }
}

func testIntRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<Int>,
    keyPath: ReferenceWritableKeyPath<Object, Int>) {
    let newValue: Int = .random(in: -256..<256)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(changes.new).to(equal(newValue))
        expect(changes.old).to(equal(oldValue))
    }
}

func testTimeIntervalRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<TimeInterval>,
    keyPath: ReferenceWritableKeyPath<Object, TimeInterval>) {
    let newValue = TimeInterval.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
        expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
    }
}

func testDoubleRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<Double>,
    keyPath: ReferenceWritableKeyPath<Object, Double>) {
    let newValue = Double.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
        expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
    }
}

func testCGFloatRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<CGFloat>,
    keyPath: ReferenceWritableKeyPath<Object, CGFloat>) {
    let newValue = CGFloat.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
        expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
    }
}

func testFloatRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<Float>,
    keyPath: ReferenceWritableKeyPath<Object, Float>) {
    let newValue = Float.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
        expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
    }
}

func testCGRectRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<CGRect>,
    keyPath: ReferenceWritableKeyPath<Object, CGRect>) {
    let newValue = CGRect(
        x: CGFloat.random(in: -1024..<1024),
        y: CGFloat.random(in: -1024..<1024),
        width: CGFloat.random(in: 0..<1024),
        height: CGFloat.random(in: 0..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.origin.x - newValue.origin.x)).to(beLessThan(0.0001))
        expect(abs(changes.new.origin.y - newValue.origin.y)).to(beLessThan(0.0001))
        expect(abs(changes.new.width - newValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.new.height - newValue.height)).to(beLessThan(0.0001))
        expect(abs(changes.old?.origin.x - oldValue.origin.x)).to(beLessThan(0.0001))
        expect(abs(changes.old?.origin.y - oldValue.origin.y)).to(beLessThan(0.0001))
        expect(abs(changes.old?.width - oldValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.old?.height - oldValue.height)).to(beLessThan(0.0001))
    }
}

func testCGPointRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<CGPoint>,
    keyPath: ReferenceWritableKeyPath<Object, CGPoint>) {
    let newValue = CGPoint(
        x: CGFloat.random(in: -1024..<1024),
        y: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.x - newValue.x)).to(beLessThan(0.0001))
        expect(abs(changes.new.y - newValue.y)).to(beLessThan(0.0001))
        expect(abs(changes.old?.x - oldValue.x)).to(beLessThan(0.0001))
        expect(abs(changes.old?.y - oldValue.y)).to(beLessThan(0.0001))
    }
}

func testSizeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<CGSize>,
    keyPath: ReferenceWritableKeyPath<Object, CGSize>) {
    let newValue = CGSize(
        width: CGFloat.random(in: 0..<1024),
        height: CGFloat.random(in: 0..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.width - newValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.new.height - newValue.height)).to(beLessThan(0.0001))
        expect(abs(changes.old?.width - oldValue.width)).to(beLessThan(0.0001))
        expect(abs(changes.old?.height - oldValue.height)).to(beLessThan(0.0001))
    }
}

func testInsetsRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<UIEdgeInsets>,
    keyPath: ReferenceWritableKeyPath<Object, UIEdgeInsets>) {
    let newValue = UIEdgeInsets(
        top: CGFloat.random(in: -1024..<1024),
        left: CGFloat.random(in: -1024..<1024),
        bottom: CGFloat.random(in: -1024..<1024),
        right: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.top - newValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.new.left - newValue.left)).to(beLessThan(0.0001))
        expect(abs(changes.new.bottom - newValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.new.right - newValue.right)).to(beLessThan(0.0001))
        expect(abs(changes.old?.top - oldValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.old?.left - oldValue.left)).to(beLessThan(0.0001))
        expect(abs(changes.old?.bottom - oldValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.old?.right - oldValue.right)).to(beLessThan(0.0001))
    }
}

@available(iOS 11.0, *)
func testDirectionalInsetsRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: BindableObservable<NSDirectionalEdgeInsets>,
    keyPath: ReferenceWritableKeyPath<Object, NSDirectionalEdgeInsets>) {
    let newValue = NSDirectionalEdgeInsets(
        top: CGFloat.random(in: -1024..<1024),
        leading: CGFloat.random(in: -1024..<1024),
        bottom: CGFloat.random(in: -1024..<1024),
        trailing: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: newValue) { changes, oldValue in
        expect(abs(changes.new.top - newValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.new.leading - newValue.leading)).to(beLessThan(0.0001))
        expect(abs(changes.new.bottom - newValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.new.trailing - newValue.trailing)).to(beLessThan(0.0001))
        expect(abs(changes.old?.top - oldValue.top)).to(beLessThan(0.0001))
        expect(abs(changes.old?.leading - oldValue.leading)).to(beLessThan(0.0001))
        expect(abs(changes.old?.bottom - oldValue.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.old?.trailing - oldValue.trailing)).to(beLessThan(0.0001))
    }
}

func - (_ lhs: Float?, _ rhs: Float) -> Float {
    guard let lValue = lhs else {
        return .nan
    }
    return lValue - rhs
}

func - (_ lhs: CGFloat?, _ rhs: CGFloat) -> CGFloat {
    guard let lValue = lhs else {
        return .nan
    }
    return lValue - rhs
}

func - (_ lhs: Double?, _ rhs: Double) -> Double {
    guard let lValue = lhs else {
        return .nan
    }
    return lValue - rhs
}

#endif
