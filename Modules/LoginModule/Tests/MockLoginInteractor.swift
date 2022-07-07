//
//  MockLoginInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 7.06.2022.
//

import Foundation
@testable import LoginModule

final class MockLoginInteractor: LoginInteractorInterface {
    var invokedLogUserIn = false
    var invokedLogUserInCount = 0
    var invokedLogUserInParameters: (email: String, password: String)?
    var invokedLogUserInParametersList = [(email: String, password: String)]()

    func logUserIn(email: String, password: String) {
        invokedLogUserIn = true
        invokedLogUserInCount += 1
        invokedLogUserInParameters = (email, password)
        invokedLogUserInParametersList.append((email, password))
    }
}
