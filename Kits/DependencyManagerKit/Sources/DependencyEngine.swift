//
//  DependencyEngine.swift
//  DependencyTut
//
//  Created by Peace on 23.06.2022.
//

import Foundation
import UIKit

public final class DependencyEngine {
    var dependencies: [ObjectIdentifier: () -> Any] = [:]
    public static let shared = DependencyEngine()
    
    private init() {}
    
    public func register(value: @autoclosure @escaping () -> Any, for interface: Any.Type) {
        dependencies[ObjectIdentifier(interface)] = value
    }
    public func read<Value>(for interface: Any.Type) -> Value {
        guard let value = dependencies[ObjectIdentifier(interface)]?() as? Value else {
            fatalError("\(interface) not found")
        }
        return value
    }
}
