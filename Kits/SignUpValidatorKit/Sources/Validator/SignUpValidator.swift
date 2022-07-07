//
//  SignUpValidator.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 24.05.2022.
//

import Foundation

public protocol SignUpValidatorInterface {
    var signUpModel: SignUpModel? { get set }
    func validateAll() throws
    func fieldIsNotMissing(signUpModel: SignUpModel) throws
    func emailLongerThanMinLetterCount(email: String) throws
    func usernameDoesNotViolatesMinLength(username: String) throws
    func usernameDoesNotViolatesMaxLength(username: String) throws
    func passwordsMatch(firstPassword: String, secondPassword: String) throws
    func passwordValid(password: String) throws
}

public final class SignUpValidator: SignUpValidatorInterface {
    public var signUpModel: SignUpModel?
    public init(signUpModel: SignUpModel?) {
        self.signUpModel = signUpModel
    }
}
// MARK: - Constant
private enum SignUpValidatorConstants {
    static let emailMinLength: Int = 5
    static let usernameMinLength: Int = 4
    static let usernameMaxLength: Int = 10
    static let passwordMinLength: Int = 6
    static let passwordMaxLength: Int = 12
}
// MARK: - Method
extension SignUpValidator {
    public func validateAll() throws {
        guard let signUpModel = signUpModel else {
            return
        }
        do {
            try fieldIsNotMissing(signUpModel: signUpModel)
            try emailLongerThanMinLetterCount(email: signUpModel.email)
            try usernameDoesNotViolatesMinLength(username: signUpModel.username)
            try usernameDoesNotViolatesMaxLength(username: signUpModel.username)
            try passwordsMatch(firstPassword: signUpModel.passwordOne, secondPassword: signUpModel.passwordTwo)
            try passwordValid(password: signUpModel.passwordTwo)
        } catch {
            throw error
        }
    }
    public func passwordsMatch(firstPassword: String, secondPassword: String) throws {
        guard firstPassword == secondPassword else {
            throw SignUpErrors.passwordsDoNotMatch
        }
    }
    public func fieldIsNotMissing(signUpModel: SignUpModel) throws {
        guard !signUpModel.email.isEmpty
            && !signUpModel.username.isEmpty
            && !signUpModel.passwordOne.isEmpty
            && !signUpModel.passwordTwo.isEmpty else {
            throw SignUpErrors.emptyField
        }
    }
    public func emailLongerThanMinLetterCount(email: String) throws {
        if let splittedEmail = email.split(separator: "@").first {
            if splittedEmail.count < SignUpValidatorConstants.emailMinLength {
                throw SignUpErrors.emailTooShort
            }
        }
    }
    public func usernameDoesNotViolatesMinLength(username: String) throws {
        guard username.count > SignUpValidatorConstants.usernameMinLength else {
            throw SignUpErrors.usernameTooShort
        }
    }
    public func usernameDoesNotViolatesMaxLength(username: String) throws {
        guard username.count < SignUpValidatorConstants.usernameMaxLength else {
            throw SignUpErrors.usernameTooLong
        }
    }
    public func passwordValid(password: String) throws {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        guard passwordPredicate.evaluate(with: password) else {
            throw SignUpErrors.passwordIsNotValid
        }
    }
}
