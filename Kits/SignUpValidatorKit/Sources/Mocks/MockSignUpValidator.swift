//
//  SignUpValidatorMock.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 24.05.2022.
//

import Foundation

final class MockSignUpValidator: SignUpValidatorInterface {
    var invokedSignUpModelSetter = false
    var invokedSignUpModelSetterCount = 0
    var invokedSignUpModel: SignUpModel?
    var invokedSignUpModelList = [SignUpModel?]()
    var invokedSignUpModelGetter = false
    var invokedSignUpModelGetterCount = 0
    var stubbedSignUpModel: SignUpModel!

    var signUpModel: SignUpModel? {
        set {
            invokedSignUpModelSetter = true
            invokedSignUpModelSetterCount += 1
            invokedSignUpModel = newValue
            invokedSignUpModelList.append(newValue)
        }
        get {
            invokedSignUpModelGetter = true
            invokedSignUpModelGetterCount += 1
            return stubbedSignUpModel
        }
    }

    var invokedValidateAll = false
    var invokedValidateAllCount = 0
    var stubbedValidateAllError: Error?

    func validateAll() throws {
        invokedValidateAll = true
        invokedValidateAllCount += 1
        if let error = stubbedValidateAllError {
            throw error
        }
    }

    var invokedFieldIsNotMissing = false
    var invokedFieldIsNotMissingCount = 0
    var invokedFieldIsNotMissingParameters: (signUpModel: SignUpModel, Void)?
    var invokedFieldIsNotMissingParametersList = [(signUpModel: SignUpModel, Void)]()
    var stubbedFieldIsNotMissingError: Error?

    func fieldIsNotMissing(signUpModel: SignUpModel) throws {
        invokedFieldIsNotMissing = true
        invokedFieldIsNotMissingCount += 1
        invokedFieldIsNotMissingParameters = (signUpModel, ())
        invokedFieldIsNotMissingParametersList.append((signUpModel, ()))
        if let error = stubbedFieldIsNotMissingError {
            throw error
        }
    }

    var invokedEmailLongerThanMinLetterCount = false
    var invokedEmailLongerThanMinLetterCountCount = 0
    var invokedEmailLongerThanMinLetterCountParameters: (email: String, Void)?
    var invokedEmailLongerThanMinLetterCountParametersList = [(email: String, Void)]()
    var stubbedEmailLongerThanMinLetterCountError: Error?

    func emailLongerThanMinLetterCount(email: String) throws {
        invokedEmailLongerThanMinLetterCount = true
        invokedEmailLongerThanMinLetterCountCount += 1
        invokedEmailLongerThanMinLetterCountParameters = (email, ())
        invokedEmailLongerThanMinLetterCountParametersList.append((email, ()))
        if let error = stubbedEmailLongerThanMinLetterCountError {
            throw error
        }
    }

    var invokedUsernameDoesNotViolatesMinLength = false
    var invokedUsernameDoesNotViolatesMinLengthCount = 0
    var invokedUsernameDoesNotViolatesMinLengthParameters: (username: String, Void)?
    var invokedUsernameDoesNotViolatesMinLengthParametersList = [(username: String, Void)]()
    var stubbedUsernameDoesNotViolatesMinLengthError: Error?

    func usernameDoesNotViolatesMinLength(username: String) throws {
        invokedUsernameDoesNotViolatesMinLength = true
        invokedUsernameDoesNotViolatesMinLengthCount += 1
        invokedUsernameDoesNotViolatesMinLengthParameters = (username, ())
        invokedUsernameDoesNotViolatesMinLengthParametersList.append((username, ()))
        if let error = stubbedUsernameDoesNotViolatesMinLengthError {
            throw error
        }
    }

    var invokedUsernameDoesNotViolatesMaxLength = false
    var invokedUsernameDoesNotViolatesMaxLengthCount = 0
    var invokedUsernameDoesNotViolatesMaxLengthParameters: (username: String, Void)?
    var invokedUsernameDoesNotViolatesMaxLengthParametersList = [(username: String, Void)]()
    var stubbedUsernameDoesNotViolatesMaxLengthError: Error?

    func usernameDoesNotViolatesMaxLength(username: String) throws {
        invokedUsernameDoesNotViolatesMaxLength = true
        invokedUsernameDoesNotViolatesMaxLengthCount += 1
        invokedUsernameDoesNotViolatesMaxLengthParameters = (username, ())
        invokedUsernameDoesNotViolatesMaxLengthParametersList.append((username, ()))
        if let error = stubbedUsernameDoesNotViolatesMaxLengthError {
            throw error
        }
    }

    var invokedPasswordsMatch = false
    var invokedPasswordsMatchCount = 0
    var invokedPasswordsMatchParameters: (firstPassword: String, secondPassword: String)?
    var invokedPasswordsMatchParametersList = [(firstPassword: String, secondPassword: String)]()
    var stubbedPasswordsMatchError: Error?

    func passwordsMatch(firstPassword: String, secondPassword: String) throws {
        invokedPasswordsMatch = true
        invokedPasswordsMatchCount += 1
        invokedPasswordsMatchParameters = (firstPassword, secondPassword)
        invokedPasswordsMatchParametersList.append((firstPassword, secondPassword))
        if let error = stubbedPasswordsMatchError {
            throw error
        }
    }

    var invokedPasswordValid = false
    var invokedPasswordValidCount = 0
    var invokedPasswordValidParameters: (password: String, Void)?
    var invokedPasswordValidParametersList = [(password: String, Void)]()
    var stubbedPasswordValidError: Error?

    func passwordValid(password: String) throws {
        invokedPasswordValid = true
        invokedPasswordValidCount += 1
        invokedPasswordValidParameters = (password, ())
        invokedPasswordValidParametersList.append((password, ()))
        if let error = stubbedPasswordValidError {
            throw error
        }
    }
}
