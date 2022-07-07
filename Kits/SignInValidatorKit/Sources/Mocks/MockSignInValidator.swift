//
//  MockSignInValidator.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 7.06.2022.
//

import Foundation

final class MockSignInValidator: SignInValidatorInterface {

    var invokedSignInModelSetter = false
    var invokedSignInModelSetterCount = 0
    var invokedSignInModel: SignInModel?
    var invokedSignInModelList = [SignInModel?]()
    var invokedSignInModelGetter = false
    var invokedSignInModelGetterCount = 0
    var stubbedSignInModel: SignInModel!

    var signInModel: SignInModel? {
        set {
            invokedSignInModelSetter = true
            invokedSignInModelSetterCount += 1
            invokedSignInModel = newValue
            invokedSignInModelList.append(newValue)
        }
        get {
            invokedSignInModelGetter = true
            invokedSignInModelGetterCount += 1
            return stubbedSignInModel
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
    var invokedFieldIsNotMissingParameters: (signInModel: SignInModel, Void)?
    var invokedFieldIsNotMissingParametersList = [(signInModel: SignInModel, Void)]()
    var stubbedFieldIsNotMissingError: Error?

    func fieldIsNotMissing(signInModel: SignInModel) throws {
        invokedFieldIsNotMissing = true
        invokedFieldIsNotMissingCount += 1
        invokedFieldIsNotMissingParameters = (signInModel, ())
        invokedFieldIsNotMissingParametersList.append((signInModel, ()))
        if let error = stubbedFieldIsNotMissingError {
            throw error
        }
    }
}
