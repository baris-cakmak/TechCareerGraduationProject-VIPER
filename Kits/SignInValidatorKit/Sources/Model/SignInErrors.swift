//
//  SignInErrors.swift
//  SignInValidatorKit
//
//  Created by Peace on 2.07.2022.
//

import Foundation

public enum SignInErrors: LocalizedError {
    case missingField

    public var errorDescription: String? {
        switch self {
        case .missingField:
            return "One of The Field is missing"
        }
    }
}
