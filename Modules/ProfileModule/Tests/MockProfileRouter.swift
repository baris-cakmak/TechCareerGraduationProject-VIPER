//
//  MockProfileRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import UIKit
@testable import ProfileModule

final class MockProfileRouter: ProfileRouterInterface {

    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController? {
        invokedNavigationControllerGetter = true
        invokedNavigationControllerGetterCount += 1
        return stubbedNavigationController
    }

    var invokedChangeWindowAsLogin = false
    var invokedChangeWindowAsLoginCount = 0

    func changeWindowAsLogin() {
        invokedChangeWindowAsLogin = true
        invokedChangeWindowAsLoginCount += 1
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
