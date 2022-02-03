import Foundation
import Quick
import Nimble
#if canImport(UIKit)
import UIKit
#endif
@testable import Pharos

class ObservableStateSpec: QuickSpec {
    override func spec() {
        describe("observable state property wrapper") {
            var initialValue: String?
            var observables: Observable<String?>!
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
            it("should notify next observer on set") {
                let new: String = .randomString()
                var didSetCount: Int = 0
                for _ in 0 ..< 3 {
                    observables.whenDidSet { changes in
                        expect(changes.old).to(equal(initialValue))
                        expect(changes.new).to(equal(new))
                        didSetCount += 1
                    }.retain()
                }
                observables.wrappedValue = new
                expect(didSetCount).to(equal(3))
            }
            it("should ignore") {
                let ignored: String = .randomString(length: 5)
                var didSetCount: Int = 0
                observables
                    .ignore {
                        $0.new == ignored
                    }
                    .whenDidSet {
                        expect($0.new).toNot(equal(ignored))
                        didSetCount += 1
                    }.retain()
                observables.wrappedValue = ignored
                expect(didSetCount).to(equal(0))
                observables.wrappedValue = .randomString(length: 10)
                expect(didSetCount).to(equal(1))
            }
            it("should delayed") {
                let newValue1: String = .randomString()
                let newValue2: String = .randomString()
                var didSetCount: Int = 0
                observables.whenDidSet { changes in
                    didSetCount += 1
                }.multipleSetDelayed(by: 0.5)
                    .retain()
                observables.wrappedValue = newValue1
                expect(didSetCount).to(equal(1))
                observables.wrappedValue = newValue2
                expect(didSetCount).to(equal(1))
                expect(didSetCount).toEventually(equal(2), pollInterval: .milliseconds(50))
            }
            it("should mapped") {
                let new: String = .randomString(length: 18)
                var didSetCount: Int = 0
                observables.mapped { $0?.count ?? 0 }
                .whenDidSet { changes in
                    expect(changes.old).to(equal(9))
                    expect(changes.new).to(equal(18))
                    didSetCount += 1
                }.retain()
                observables.wrappedValue = new
                expect(didSetCount).to(equal(1))
            }
            it("should combine 2 observables") {
                let number = Int.random(in: 0..<100)
                var didSetCount: Int = 0
                var latestChanges: Changes<(String?, Int)> = .init(old: (initialValue, number), new: (initialValue, number), source: self)
                let observables2: Observable<Int> = .init(wrappedValue: number)
                observables.compactCombine(with: observables2)
                    .whenDidSet { changes in
                        latestChanges = changes
                        didSetCount += 1
                    }.retain()
                let newStr: String = .randomString()
                observables.wrappedValue = newStr
                expect(didSetCount).to(equal(1))
                expect(latestChanges.old?.0).to(equal(initialValue))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(number))
                expect(latestChanges.new.1).to(equal(number))
                let newInt: Int = Int.random(in: 100..<200)
                observables2.wrappedValue = newInt
                expect(didSetCount).to(equal(2))
                expect(latestChanges.old?.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(number))
                expect(latestChanges.new.1).to(equal(newInt))
            }
            it("should combine 3 observables") {
                let int = Int.random(in: 0..<100)
                let double = Double.random(in: 0..<10)
                var didSetCount: Int = 0
                var latestChanges: Changes<(String?, Int, Double)> = .init(old: (initialValue, int, double), new: (initialValue, int, double), source: self)
                let observables2: Observable<Int> = .init(wrappedValue: int)
                let observables3: Observable<Double> = .init(wrappedValue: double)
                observables.compactCombine(with: observables2, observables3)
                    .whenDidSet { changes in
                        latestChanges = changes
                        didSetCount += 1
                    }.retain()
                let newStr: String = .randomString()
                observables.wrappedValue = newStr
                expect(didSetCount).to(equal(1))
                expect(latestChanges.old?.0).to(equal(initialValue))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(int))
                expect(latestChanges.old?.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                let newInt: Int = Int.random(in: 100..<200)
                observables2.wrappedValue = newInt
                expect(didSetCount).to(equal(2))
                expect(latestChanges.old?.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old?.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                let newDouble: Double = Double.random(in: 10..<20)
                observables3.wrappedValue = newDouble
                expect(didSetCount).to(equal(3))
                expect(latestChanges.old?.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(newInt))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old?.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(newDouble))
            }
            it("should combine 4 observables") {
                let int = Int.random(in: 0..<100)
                let double = Double.random(in: 0..<10)
                let bool = Bool.random()
                var didSetCount: Int = 0
                var latestChanges: Changes<(String?, Int, Double, Bool)> = .init(old: (initialValue, int, double, bool), new: (initialValue, int, double, bool), source: self)
                let observables2: Observable<Int> = .init(wrappedValue: int)
                let observables3: Observable<Double> = .init(wrappedValue: double)
                let observables4: Observable<Bool> = .init(wrappedValue: bool)
                observables.compactCombine(with: observables2, observables3, observables4)
                    .whenDidSet { changes in
                        latestChanges = changes
                        didSetCount += 1
                    }.retain()
                let newStr: String = .randomString()
                observables.wrappedValue = newStr
                expect(didSetCount).to(equal(1))
                expect(latestChanges.old?.0).to(equal(initialValue))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(int))
                expect(latestChanges.old?.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                expect(latestChanges.old?.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(bool))
                let newInt: Int = Int.random(in: 100..<200)
                observables2.wrappedValue = newInt
                expect(didSetCount).to(equal(2))
                expect(latestChanges.old?.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old?.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                expect(latestChanges.old?.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(bool))
                let newDouble: Double = Double.random(in: 10..<20)
                observables3.wrappedValue = newDouble
                expect(didSetCount).to(equal(3))
                expect(latestChanges.old?.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(newInt))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old?.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(newDouble))
                expect(latestChanges.old?.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(bool))
                let newBool: Bool = !bool
                observables4.wrappedValue = newBool
                expect(didSetCount).to(equal(4))
                expect(latestChanges.old?.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old?.1).to(equal(newInt))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old?.2).to(equal(newDouble))
                expect(latestChanges.new.2).to(equal(newDouble))
                expect(latestChanges.old?.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(newBool))
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
                expect(source as? Observable<String?>).toNot(beNil())
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
                expect(source as? Observable<String?>).toNot(beNil())
                expect(didSetCount).to(equal(1))
            }
            it("should auto dereference relay when AutoDereferencer is dereferenced") {
                let retainer: Retainer = .init()
                var didSetCount: Int = 0
                var relay: ObservedRelay<String?>? = observables
                    .whenDidSet { changes in
                        didSetCount += 1
                    }
                relay?.retained(by: retainer)
                weak var weakRelay = relay
                relay = nil
                observables.wrappedValue = .randomString()
                expect(didSetCount).to(equal(1))
                expect(weakRelay).toNot(beNil())
                retainer.discardAll()
                observables.wrappedValue = .randomString()
                expect(weakRelay).to(beNil())
                expect(didSetCount).to(equal(1))
            }
        }
    }
}

class Dummy: NSObject {
    @objc dynamic var text: String?
}

extension String {
    static func randomString(length: Int = 8) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
