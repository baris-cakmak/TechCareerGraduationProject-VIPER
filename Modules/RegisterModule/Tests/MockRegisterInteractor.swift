//
//  MockRegisterInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 25.05.2022.
//

import Foundation
@testable import RegisterModule
@testable import CommonKit

final class MockRegisterInteractor: RegisterInteractorInterface {

    var invokedRegisterUser = false
    var invokedRegisterUserCount = 0
    var invokedRegisterUserParameters: (credentials: AuthCredentials, Void)?
    var invokedRegisterUserParametersList = [(credentials: AuthCredentials, Void)]()

    func registerUser(with credentials: AuthCredentials) {
        invokedRegisterUser = true
        invokedRegisterUserCount += 1
        invokedRegisterUserParameters = (credentials, ())
        invokedRegisterUserParametersList.append((credentials, ()))
    }
}
