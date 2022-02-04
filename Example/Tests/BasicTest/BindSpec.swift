import Foundation
import Quick
import Nimble
#if canImport(UIKit)
import UIKit
#endif
@testable import Pharos

class BindSpec: QuickSpec {
    override func spec() {
        var initialValue: String?
        var observables: Subject<String?>!
        var object: Dummy!
        #if canImport(UIKit)
        var label: UILabel!
        #endif
        beforeEach {
            initialValue = .randomString(length: 9)
            observables = .init(wrappedValue: initialValue)
            object = Dummy()
            #if canImport(UIKit)
            label = .init()
            #endif
        }
        #if canImport(UIKit)
        it("should bond with UIView") {
            var source: Any = self
            var didSetCount: Int = 0
            observables.bind(with: label.bindables.text)
                .retain()
            observables.whenDidSet { changes in
                source = changes.source
                didSetCount += 1
            }.retain()
            let fromLabel = String.randomString()
            label.text = fromLabel
            expect(observables.wrappedValue).to(equal(fromLabel))
            expect(source as? UILabel).to(equal(label))
            expect(didSetCount).to(equal(1))
            let fromState = String.randomString()
            observables.wrappedValue = fromState
            expect(observables.wrappedValue).to(equal(fromState))
            expect(source as? Subject<String?>).toNot(beNil())
            expect(didSetCount).to(equal(2))
        }
        #endif
        it("should bear data to NSObject") {
            var source: Any = self
            var didSetCount: Int = 0
            observables.relayChanges(to: object.relayables.text)
                .retain()
            observables.whenDidSet { changes in
                source = changes.source
                didSetCount += 1
            }.retain()
            expect(object.text).to(beNil())
            expect(didSetCount).to(equal(0))
            let fromObject = String.randomString()
            object.text = fromObject
            expect(observables.wrappedValue).toNot(equal(fromObject))
            expect(source as? Dummy).to(beNil())
            expect(didSetCount).to(equal(0))
            let fromState = String.randomString()
            observables.wrappedValue = fromState
            expect(observables.wrappedValue).to(equal(fromState))
            expect(source as? Subject<String?>).toNot(beNil())
            expect(didSetCount).to(equal(1))
        }
    }
}

class Dummy: NSObject {
    @objc dynamic var text: String?
}
