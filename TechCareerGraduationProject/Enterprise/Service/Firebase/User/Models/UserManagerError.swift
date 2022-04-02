//
//  UserManagerError.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import Foundation

enum UserManagerError: Error {
    case noUser

}


extension UserManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noUser:
            return NSLocalizedString("Please Tap Logout Button on Top Right Corner to Register", comment: "My error")
        }
    }
}
