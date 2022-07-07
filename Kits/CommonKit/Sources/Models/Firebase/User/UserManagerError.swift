//
//  UserManagerError.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import Foundation

public enum UserManagerError: Error {
    case noUser
}

extension UserManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noUser:
            return NSLocalizedString("No User", comment: "My error")
        }
    }
}
