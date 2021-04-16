import Foundation
import Quick
import Nimble
import Pharos
#if canImport(UIKit)
import UIKit
#endif
import Quick
import Nimble
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
                observables.relay.whenDidSet { changes in
                    expect(changes.old).to(equal(initialValue))
                    expect(changes.new).to(equal(new))
                    didSetCount += 1
                }.nextRelay().whenDidSet { changes in
                    expect(changes.old).to(equal(initialValue))
                    expect(changes.new).to(equal(new))
                    didSetCount += 1
                }.nextRelay().whenDidSet { changes in
                    expect(changes.old).to(equal(initialValue))
                    expect(changes.new).to(equal(new))
                    didSetCount += 1
                }
                observables.wrappedValue = new
                expect(didSetCount).to(equal(3))
            }
            it("should delayed") {
                let newValue1: String = .randomString()
                let newValue2: String = .randomString()
                var didSetCount: Int = 0
                observables.relay.whenDidSet { changes in
                    didSetCount += 1
                }.multipleSetDelayed(by: 0.5)
                observables.wrappedValue = newValue1
                expect(didSetCount).to(equal(1))
                observables.wrappedValue = newValue2
                expect(didSetCount).to(equal(1))
                expect(didSetCount).toEventually(equal(2), pollInterval: .milliseconds(50))
            }
            it("should mapped") {
                let new: String = .randomString(length: 18)
                var didSetCount: Int = 0
                observables.relay.map { $0?.count ?? 0 }
                    .whenDidSet { changes in
                        expect(changes.old).to(equal(9))
                        expect(changes.new).to(equal(18))
                        didSetCount += 1
                    }
                observables.wrappedValue = new
                expect(didSetCount).to(equal(1))
            }
            it("should merge 2 observables") {
                let number = Int.random(in: 0..<100)
                var didSetCount: Int = 0
                var latestChanges: Changes<(String?, Int)> = .init(old: (initialValue, number), new: (initialValue, number), source: self)
                let observables2: Observable<Int> = .init(wrappedValue: number)
                observables.relay.merge(with: observables2.relay).whenDidSet { changes in
                    latestChanges = changes
                    didSetCount += 1
                }
                let newStr: String = .randomString()
                observables.wrappedValue = newStr
                expect(didSetCount).to(equal(1))
                expect(latestChanges.old.0).to(equal(initialValue))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(number))
                expect(latestChanges.new.1).to(equal(number))
                let newInt: Int = Int.random(in: 100..<200)
                observables2.wrappedValue = newInt
                expect(didSetCount).to(equal(2))
                expect(latestChanges.old.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(number))
                expect(latestChanges.new.1).to(equal(newInt))
            }
            it("should merge 3 observables") {
                let int = Int.random(in: 0..<100)
                let double = Double.random(in: 0..<10)
                var didSetCount: Int = 0
                var latestChanges: Changes<(String?, Int, Double)> = .init(old: (initialValue, int, double), new: (initialValue, int, double), source: self)
                let observables2: Observable<Int> = .init(wrappedValue: int)
                let observables3: Observable<Double> = .init(wrappedValue: double)
                observables.relay.merge(with: observables2.relay, observables3.relay).whenDidSet { changes in
                    latestChanges = changes
                    didSetCount += 1
                }
                let newStr: String = .randomString()
                observables.wrappedValue = newStr
                expect(didSetCount).to(equal(1))
                expect(latestChanges.old.0).to(equal(initialValue))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(int))
                expect(latestChanges.old.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                let newInt: Int = Int.random(in: 100..<200)
                observables2.wrappedValue = newInt
                expect(didSetCount).to(equal(2))
                expect(latestChanges.old.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                let newDouble: Double = Double.random(in: 10..<20)
                observables3.wrappedValue = newDouble
                expect(didSetCount).to(equal(3))
                expect(latestChanges.old.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(newInt))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(newDouble))
            }
            it("should merge 4 observables") {
                let int = Int.random(in: 0..<100)
                let double = Double.random(in: 0..<10)
                let bool = Bool.random()
                var didSetCount: Int = 0
                var latestChanges: Changes<(String?, Int, Double, Bool)> = .init(old: (initialValue, int, double, bool), new: (initialValue, int, double, bool), source: self)
                let observables2: Observable<Int> = .init(wrappedValue: int)
                let observables3: Observable<Double> = .init(wrappedValue: double)
                let observables4: Observable<Bool> = .init(wrappedValue: bool)
                observables.relay.merge(with: observables2.relay, observables3.relay, observables4.relay).whenDidSet { changes in
                    latestChanges = changes
                    didSetCount += 1
                }
                let newStr: String = .randomString()
                observables.wrappedValue = newStr
                expect(didSetCount).to(equal(1))
                expect(latestChanges.old.0).to(equal(initialValue))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(int))
                expect(latestChanges.old.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                expect(latestChanges.old.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(bool))
                let newInt: Int = Int.random(in: 100..<200)
                observables2.wrappedValue = newInt
                expect(didSetCount).to(equal(2))
                expect(latestChanges.old.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(int))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(double))
                expect(latestChanges.old.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(bool))
                let newDouble: Double = Double.random(in: 10..<20)
                observables3.wrappedValue = newDouble
                expect(didSetCount).to(equal(3))
                expect(latestChanges.old.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(newInt))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old.2).to(equal(double))
                expect(latestChanges.new.2).to(equal(newDouble))
                expect(latestChanges.old.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(bool))
                let newBool: Bool = Bool.random()
                observables4.wrappedValue = newBool
                expect(didSetCount).to(equal(4))
                expect(latestChanges.old.0).to(equal(newStr))
                expect(latestChanges.new.0).to(equal(newStr))
                expect(latestChanges.old.1).to(equal(newInt))
                expect(latestChanges.new.1).to(equal(newInt))
                expect(latestChanges.old.2).to(equal(newDouble))
                expect(latestChanges.new.2).to(equal(newDouble))
                expect(latestChanges.old.3).to(equal(bool))
                expect(latestChanges.new.3).to(equal(newBool))
            }
            #if canImport(UIKit)
            it("should bond with UIView") {
                var source: Any = self
                var didSetCount: Int = 0
                observables.relay.bonding(with: .relay(of: label, \.text))
                    .whenDidSet { changes in
                        source = changes.source
                        didSetCount += 1
                    }
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
            it("should bond and apply to UIView") {
                var source: Any = self
                var didSetCount: Int = 0
                observables.relay.bondAndApply(to: .relay(of: label, \.text))
                    .whenDidSet { changes in
                        source = changes.source
                        didSetCount += 1
                    }
                expect(label.text).to(equal(initialValue))
                expect(didSetCount).to(equal(0))
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
            it("should bond and map from UIView") {
                var source: Any = self
                var didSetCount: Int = 0
                label.text = .randomString()
                observables.relay.bondAndMap(from: .relay(of: label, \.text))
                    .whenDidSet { changes in
                        source = changes.source
                        didSetCount += 1
                    }
                expect(observables.wrappedValue).to(equal(label.text))
                expect(didSetCount).to(equal(0))
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
            it("should bond with NSObject") {
                var source: Any = self
                var didSetCount: Int = 0
                observables.relay.bonding(with: .relay(of: object, \.text))
                    .whenDidSet { changes in
                        source = changes.source
                        didSetCount += 1
                    }
                let fromObject = String.randomString()
                object.text = fromObject
                expect(observables.wrappedValue).to(equal(fromObject))
                expect(source as? Dummy).to(equal(object))
                expect(didSetCount).to(equal(1))
                let fromState = String.randomString()
                observables.wrappedValue = fromState
                expect(observables.wrappedValue).to(equal(fromState))
                expect(source as? Observable<String?>).toNot(beNil())
                expect(didSetCount).to(equal(2))
            }
            it("should bond and apply to NSObject") {
                var source: Any = self
                var didSetCount: Int = 0
                observables.relay.bondAndApply(to: .relay(of: object, \.text))
                    .whenDidSet { changes in
                        source = changes.source
                        didSetCount += 1
                    }
                expect(object.text).to(equal(initialValue))
                expect(didSetCount).to(equal(0))
                let fromObject = String.randomString()
                object.text = fromObject
                expect(observables.wrappedValue).to(equal(fromObject))
                expect(source as? Dummy).to(equal(object))
                expect(didSetCount).to(equal(1))
                let fromState = String.randomString()
                observables.wrappedValue = fromState
                expect(observables.wrappedValue).to(equal(fromState))
                expect(source as? Observable<String?>).toNot(beNil())
                expect(didSetCount).to(equal(2))
            }
            it("should bond and map from NSObject") {
                var source: Any = self
                var didSetCount: Int = 0
                object.text = .randomString()
                observables.relay.bondAndMap(from: .relay(of: object, \.text))
                    .whenDidSet { changes in
                        source = changes.source
                        didSetCount += 1
                    }
                expect(observables.wrappedValue).to(equal(object.text))
                expect(didSetCount).to(equal(0))
                let fromObject = String.randomString()
                object.text = fromObject
                expect(observables.wrappedValue).to(equal(fromObject))
                expect(source as? Dummy).to(equal(object))
                expect(didSetCount).to(equal(1))
                let fromState = String.randomString()
                observables.wrappedValue = fromState
                expect(observables.wrappedValue).to(equal(fromState))
                expect(source as? Observable<String?>).toNot(beNil())
                expect(didSetCount).to(equal(2))
            }
            it("should auto dereference relay when AutoDereferencer is dereferenced") {
                let dereferencer: Dereferencer = .init()
                var didSetCount: Int = 0
                weak var relay1 = observables.relay.nextRelay()
                    .referenceManaged(by: dereferencer)
                    .whenDidSet { changes in
                        didSetCount += 1
                    }
                weak var relay2 = relay1?.nextRelay()
                    .whenDidSet { changes in
                        didSetCount += 1
                    }
                observables.wrappedValue = .randomString()
                expect(didSetCount).to(equal(2))
                expect(relay1).toNot(beNil())
                expect(relay2).toNot(beNil())
                dereferencer.discardAll()
                observables.wrappedValue = .randomString()
                expect(relay1).to(beNil())
                expect(relay2).to(beNil())
                expect(didSetCount).to(equal(2))
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
