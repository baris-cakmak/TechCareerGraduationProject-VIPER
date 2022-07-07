//
//  SignUpErrors.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 24.05.2022.
//

import Foundation

public enum SignUpErrors: LocalizedError {
    case emptyField
    case emailTooShort
    case usernameTooShort
    case usernameTooLong
    case passwordsDoNotMatch
    case passwordIsNotValid
    case emailAdressMustContainAtSymbol
    case missingField
    
    public var errorDescription: String? {
        switch self {
        case .emailTooShort:
            return "Email is Too Short"
            
        case .usernameTooShort:
            return "Username is Too Short"
            
        case .usernameTooLong:
            return "Username is Too Long"
            
        case .emptyField:
            return "Field is Empty"
            
        case .passwordsDoNotMatch:
            return "Passwords Are Not Identical"
        
        case .passwordIsNotValid:
            return "Password must be longer than 6 and contain special character"
            
        case .emailAdressMustContainAtSymbol:
            return "Email needs @ symbol"
        
        case .missingField:
            return "One of the field is nil"
        }
    }
}
