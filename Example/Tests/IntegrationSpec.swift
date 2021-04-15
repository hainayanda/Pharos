import Quick
import Nimble
import Pharos
import UIKit
import Quick
import Nimble
@testable import Pharos

class ObservableStateSpec: QuickSpec {
    override func spec() {
        describe("observable state property wrapper") {
            var initialValue: String?
            var observables: Observable<String?>!
            var label: UILabel!
            beforeEach {
                initialValue = .randomString(length: 9)
                observables = .init(wrappedValue: initialValue)
                label = .init()
            }
            it("should notify next observer on set") {
                let new: String = .randomString()
                var didSetCount: Int = 0
                observables.relay.whenDidSet { changes in
                    expect(changes.old).to(equal(initialValue))
                    expect(changes.new).to(equal(new))
                    didSetCount += 1
                }.addNext().whenDidSet { changes in
                    expect(changes.old).to(equal(initialValue))
                    expect(changes.new).to(equal(new))
                    didSetCount += 1
                }.addNext().whenDidSet { changes in
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
            it("should bond with view") {
                var source: Any = self
                var didSetCount: Int = 0
                observables.relay.bond(with: label, \.text).whenDidSet { changes in
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
            it("should auto dereference relay when AutoDereferencer is dereferenced") {
                let dereferencer: Dereferencer = .init()
                var didSetCount: Int = 0
                weak var relay = observables.relay.addNext(with: dereferencer).whenDidSet { changes in
                    didSetCount += 1
                }
                observables.wrappedValue = .randomString()
                expect(didSetCount).to(equal(1))
                expect(relay).toNot(beNil())
                dereferencer.discardAll()
                observables.wrappedValue = .randomString()
                expect(relay).to(beNil())
                expect(didSetCount).to(equal(1))
            }
        }
    }
}

extension String {
    public static func randomString(length: Int = 9) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}
