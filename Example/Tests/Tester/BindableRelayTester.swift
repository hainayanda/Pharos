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

// swiftlint:disable file_length

func testRelay<Object: NSObject, Property>(
    for underlyingObject: Object,
    relay: Observable<Property>,
    keyPath: ReferenceWritableKeyPath<Object, Property>,
    with new: Property,
    test: @escaping (Changes<Property>, Property) -> Void) {
    let retainer: Retainer = Retainer()
    defer {
        retainer.discardAll()
    }
    let old: Property = underlyingObject[keyPath: keyPath]
    waitUntil { done in
        relay
            .observeChange { changes in
                test(changes, old)
                done()
            }
            .retained(by: retainer)
        underlyingObject[keyPath: keyPath] = new
    }
        retainer.discardAll()
}

func testBoolRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<Bool>,
    keyPath: ReferenceWritableKeyPath<Object, Bool>) {
    let new: Bool = .random()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
            expect(changes.old).to(equal(old))
    }
}

func testBreakModeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSLineBreakMode>,
    keyPath: ReferenceWritableKeyPath<Object, NSLineBreakMode>) {
    let new: NSLineBreakMode = .byClipping
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testBaselineRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIBaselineAdjustment>,
    keyPath: ReferenceWritableKeyPath<Object, UIBaselineAdjustment>) {
    let new: UIBaselineAdjustment = .alignBaselines
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testLineBreakRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSParagraphStyle.LineBreakStrategy>,
    keyPath: ReferenceWritableKeyPath<Object, NSParagraphStyle.LineBreakStrategy>) {
    let new: NSParagraphStyle.LineBreakStrategy = .pushOut
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testArrayImageRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<[UIImage]?>,
    keyPath: ReferenceWritableKeyPath<Object, [UIImage]?>) {
    let new: [UIImage]? = [UIImage()]
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? [UIImage]).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testTextAlignementRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSTextAlignment>,
    keyPath: ReferenceWritableKeyPath<Object, NSTextAlignment>) {
    let new: NSTextAlignment = .justified
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testOffsetRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIOffset>,
    keyPath: ReferenceWritableKeyPath<Object, UIOffset>) {
    let new: UIOffset = .init(horizontal: 123, vertical: 456)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new.horizontal - new.horizontal)).to(beLessThan(0.0001))
        expect(abs(changes.old?.horizontal - old.horizontal)).to(beLessThan(0.0001))
        expect(abs(changes.new.vertical - new.vertical)).to(beLessThan(0.0001))
        expect(abs(changes.old?.vertical - old.vertical)).to(beLessThan(0.0001))
    }
}

func testBorderStyleRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UITextField.BorderStyle>,
    keyPath: ReferenceWritableKeyPath<Object, UITextField.BorderStyle>) {
    let new: UITextField.BorderStyle = .bezel
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testRangeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSRange>,
    keyPath: ReferenceWritableKeyPath<Object, NSRange>) {
    let new: NSRange = NSRange(location: 0, length: 0)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testDataDetectorRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIDataDetectorTypes>,
    keyPath: ReferenceWritableKeyPath<Object, UIDataDetectorTypes>) {
    let new: UIDataDetectorTypes = .address
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testAttributedStringRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSAttributedString>,
    keyPath: ReferenceWritableKeyPath<Object, NSAttributedString>) {
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: NSAttributedString(string: "test")) { changes, old in
        expect(changes.new.string).to(equal("test"))
        expect(changes.old?.string).to(equal(old.string))
    }
}

func testOptAttributedStringRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSAttributedString?>,
    keyPath: ReferenceWritableKeyPath<Object, NSAttributedString?>) {
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: NSAttributedString(string: "test")) { changes, old in
        expect(changes.new?.string).to(equal("test"))
        if old?.string == nil {
            expect(changes.old??.string).to(beNil())
        } else {
            expect(changes.old??.string).to(equal(old?.string))
        }
    }
}

func testFontRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIFont?>,
    keyPath: ReferenceWritableKeyPath<Object, UIFont?>) {
    let new: UIFont = UIFont.systemFont(ofSize: 123, weight: .medium)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? UIFont).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testViewModeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UITextField.ViewMode>,
    keyPath: ReferenceWritableKeyPath<Object, UITextField.ViewMode>) {
    let new: UITextField.ViewMode = .always
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testImageRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIImage?>,
    keyPath: ReferenceWritableKeyPath<Object, UIImage?>) {
    let new: UIImage = UIImage()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? UIImage).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testStringRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<String?>,
    keyPath: ReferenceWritableKeyPath<Object, String?>) {
    let new: String = "testing pharos"
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? String).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testColorRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIColor?>,
    keyPath: ReferenceWritableKeyPath<Object, UIColor?>) {
    let new: UIColor = .brown
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? UIColor).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testVisualEffectRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIVisualEffect?>,
    keyPath: ReferenceWritableKeyPath<Object, UIVisualEffect?>) {
    let new: UIVisualEffect = UIVisualEffect()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? UIVisualEffect).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testAxisRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSLayoutConstraint.Axis>,
    keyPath: ReferenceWritableKeyPath<Object, NSLayoutConstraint.Axis>) {
    let new: NSLayoutConstraint.Axis = .horizontal
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testDistributionRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIStackView.Distribution>,
    keyPath: ReferenceWritableKeyPath<Object, UIStackView.Distribution>) {
    let new: UIStackView.Distribution = .equalCentering
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testAlignmentRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIStackView.Alignment>,
    keyPath: ReferenceWritableKeyPath<Object, UIStackView.Alignment>) {
    let new: UIStackView.Alignment = .center
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testViewRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIView?>,
    keyPath: ReferenceWritableKeyPath<Object, UIView?>) {
    let new: UIView = UIView()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? UIView).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testRefreshRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIRefreshControl?>,
    keyPath: ReferenceWritableKeyPath<Object, UIRefreshControl?>) {
    let new: UIRefreshControl = UIRefreshControl()
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        if old == nil {
            expect(changes.old as? UIRefreshControl).to(beNil())
        } else {
            expect(changes.old).to(equal(old))
        }
    }
}

func testIntRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<Int>,
    keyPath: ReferenceWritableKeyPath<Object, Int>) {
    let new: Int = .random(in: -256..<256)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(changes.new).to(equal(new))
        expect(changes.old).to(equal(old))
    }
}

func testTimeIntervalRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<TimeInterval>,
    keyPath: ReferenceWritableKeyPath<Object, TimeInterval>) {
    let new = TimeInterval.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new - new)).to(beLessThan(0.0001))
        expect(abs(changes.old - old)).to(beLessThan(0.0001))
    }
}

func testDoubleRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<Double>,
    keyPath: ReferenceWritableKeyPath<Object, Double>) {
    let new = Double.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new - new)).to(beLessThan(0.0001))
        expect(abs(changes.old - old)).to(beLessThan(0.0001))
    }
}

func testCGFloatRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<CGFloat>,
    keyPath: ReferenceWritableKeyPath<Object, CGFloat>) {
    let new = CGFloat.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new - new)).to(beLessThan(0.0001))
        expect(abs(changes.old - old)).to(beLessThan(0.0001))
    }
}

func testFloatRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<Float>,
    keyPath: ReferenceWritableKeyPath<Object, Float>) {
    let new = Float.random(in: -1024..<1024)
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new - new)).to(beLessThan(0.0001))
        expect(abs(changes.old - old)).to(beLessThan(0.0001))
    }
}

func testCGRectRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<CGRect>,
    keyPath: ReferenceWritableKeyPath<Object, CGRect>) {
    let new = CGRect(
        x: CGFloat.random(in: -1024..<1024),
        y: CGFloat.random(in: -1024..<1024),
        width: CGFloat.random(in: 0..<1024),
        height: CGFloat.random(in: 0..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new.origin.x - new.origin.x)).to(beLessThan(0.0001))
        expect(abs(changes.new.origin.y - new.origin.y)).to(beLessThan(0.0001))
        expect(abs(changes.new.width - new.width)).to(beLessThan(0.0001))
        expect(abs(changes.new.height - new.height)).to(beLessThan(0.0001))
        expect(abs(changes.old?.origin.x - old.origin.x)).to(beLessThan(0.0001))
        expect(abs(changes.old?.origin.y - old.origin.y)).to(beLessThan(0.0001))
        expect(abs(changes.old?.width - old.width)).to(beLessThan(0.0001))
        expect(abs(changes.old?.height - old.height)).to(beLessThan(0.0001))
    }
}

func testCGPointRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<CGPoint>,
    keyPath: ReferenceWritableKeyPath<Object, CGPoint>) {
    let new = CGPoint(
        x: CGFloat.random(in: -1024..<1024),
        y: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new.x - new.x)).to(beLessThan(0.0001))
        expect(abs(changes.new.y - new.y)).to(beLessThan(0.0001))
        expect(abs(changes.old?.x - old.x)).to(beLessThan(0.0001))
        expect(abs(changes.old?.y - old.y)).to(beLessThan(0.0001))
    }
}

func testSizeRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<CGSize>,
    keyPath: ReferenceWritableKeyPath<Object, CGSize>) {
    let new = CGSize(
        width: CGFloat.random(in: 0..<1024),
        height: CGFloat.random(in: 0..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new.width - new.width)).to(beLessThan(0.0001))
        expect(abs(changes.new.height - new.height)).to(beLessThan(0.0001))
        expect(abs(changes.old?.width - old.width)).to(beLessThan(0.0001))
        expect(abs(changes.old?.height - old.height)).to(beLessThan(0.0001))
    }
}

func testInsetsRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<UIEdgeInsets>,
    keyPath: ReferenceWritableKeyPath<Object, UIEdgeInsets>) {
    let new = UIEdgeInsets(
        top: CGFloat.random(in: -1024..<1024),
        left: CGFloat.random(in: -1024..<1024),
        bottom: CGFloat.random(in: -1024..<1024),
        right: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new.top - new.top)).to(beLessThan(0.0001))
        expect(abs(changes.new.left - new.left)).to(beLessThan(0.0001))
        expect(abs(changes.new.bottom - new.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.new.right - new.right)).to(beLessThan(0.0001))
        expect(abs(changes.old?.top - old.top)).to(beLessThan(0.0001))
        expect(abs(changes.old?.left - old.left)).to(beLessThan(0.0001))
        expect(abs(changes.old?.bottom - old.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.old?.right - old.right)).to(beLessThan(0.0001))
    }
}

@available(iOS 11.0, *)
func testDirectionalInsetsRelay<Object: NSObject>(
    for underlyingObject: Object,
    relay: Observable<NSDirectionalEdgeInsets>,
    keyPath: ReferenceWritableKeyPath<Object, NSDirectionalEdgeInsets>) {
    let new = NSDirectionalEdgeInsets(
        top: CGFloat.random(in: -1024..<1024),
        leading: CGFloat.random(in: -1024..<1024),
        bottom: CGFloat.random(in: -1024..<1024),
        trailing: CGFloat.random(in: -1024..<1024)
    )
    testRelay(
        for: underlyingObject,
        relay: relay,
        keyPath: keyPath,
        with: new) { changes, old in
        expect(abs(changes.new.top - new.top)).to(beLessThan(0.0001))
        expect(abs(changes.new.leading - new.leading)).to(beLessThan(0.0001))
        expect(abs(changes.new.bottom - new.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.new.trailing - new.trailing)).to(beLessThan(0.0001))
        expect(abs(changes.old?.top - old.top)).to(beLessThan(0.0001))
        expect(abs(changes.old?.leading - old.leading)).to(beLessThan(0.0001))
        expect(abs(changes.old?.bottom - old.bottom)).to(beLessThan(0.0001))
        expect(abs(changes.old?.trailing - old.trailing)).to(beLessThan(0.0001))
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
