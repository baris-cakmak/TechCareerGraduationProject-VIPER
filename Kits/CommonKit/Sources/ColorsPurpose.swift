//
//  ColorsPurpose.swift
//  CommonKit
//
//  Created by Peace on 25.06.2022.
//

import UIKit

public enum Colors: String {
    case red
    case green
    case greenish
    case brokenWhite
    
    public var colorDescription: UIColor {
        switch self {
        case .red:
            return .init(red: 0.85, green: 0.25, blue: 0.47, alpha: 1)
            
        case .green:
            return .init(red: 0.0, green: 0.87, blue: 0.06, alpha: 1)
            
        case .greenish:
            return .init(red: 0.63, green: 0.89, blue: 0.45, alpha: 1)
            
        case .brokenWhite:
            return .init(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.96)
        }
    }
}
