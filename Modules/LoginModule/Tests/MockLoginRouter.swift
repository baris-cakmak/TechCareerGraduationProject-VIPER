//
//  MockLoginRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 7.06.2022.
//

import UIKit
@testable import LoginModule

final class MockLoginRouter: LoginRouterInterface {

    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController? {
        invokedNavigationControllerGetter = true
        invokedNavigationControllerGetterCount += 1
        return stubbedNavigationController
    }

    var invokedShowSignUpPage = false
    var invokedShowSignUpPageCount = 0

    func showSignUpPage() {
        invokedShowSignUpPage = true
        invokedShowSignUpPageCount += 1
    }

    var invokedChangeWindowAsMainTab = false
    var invokedChangeWindowAsMainTabCount = 0

    func changeWindowAsMainTab() {
        invokedChangeWindowAsMainTab = true
        invokedChangeWindowAsMainTabCount += 1
    }

    var invokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedShowAlertParameters: (message: String, Void)?
    var invokedShowAlertParametersList = [(message: String, Void)]()

    func showAlert(message: String) {
        invokedShowAlert = true
        invokedShowAlertCount += 1
        invokedShowAlertParameters = (message, ())
        invokedShowAlertParametersList.append((message, ()))
    }
}
