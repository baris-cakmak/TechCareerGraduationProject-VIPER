//
//  Dependency.swift
//  DependencyTut
//
//  Created by Peace on 23.06.2022.
//

import UIKit

@propertyWrapper
public final class Dependency<Value> {
    private var value: Value?
    private let engine: DependencyEngine
    public init(engine: DependencyEngine = .shared) {
        self.engine = engine
    }
    public init(wrappedValue: Value) {
        self.value = wrappedValue
        self.engine = .shared
    }
    public var wrappedValue: Value {
        get {
            if let value = value {
                return value
            } else {
                let value: Value = engine.read(for: Value.self)
                self.value = value
                return value
            }
        }
        set {
            value = newValue
        }
    }
}
