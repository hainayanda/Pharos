//
//  ObservableMutator.swift
//  Pharos
//
//  Created by Nayanda Haberty on 17/04/21.
//

import Foundation

@propertyWrapper
public class ObservableMutator<Wrapped>: Observable<Wrapped> {
    private var getter: (() -> Wrapped)?
    private var setter: ((Wrapped) -> Void)?
    public override var wrappedValue: Wrapped {
        get {
            getter?() ?? _wrappedValue
        }
        set {
            setter?(newValue)
            setAndInformToRelay(with: Changes(old: _wrappedValue, new: newValue, source: self))
        }
    }
    
    public override init(wrappedValue: Wrapped) {
        super.init(wrappedValue: wrappedValue)
    }
    
    public init(get getter: @escaping () -> Wrapped, set setter: @escaping (Wrapped) -> Void) {
        self.getter = getter
        self.setter = setter
        super.init(wrappedValue: getter())
    }
    
    public func mutator(get getter: @escaping () -> Wrapped, set setter: @escaping (Wrapped) -> Void) {
        self.getter = getter
        self.setter = setter
    }
}
