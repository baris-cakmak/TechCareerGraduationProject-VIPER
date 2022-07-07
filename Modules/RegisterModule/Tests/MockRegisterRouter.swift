//
//  MockRegisterRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 25.05.2022.
//

import UIKit
@testable import RegisterModule

final class MockRegisterRouter: RegisterRouterInterface {

    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController? {
        invokedNavigationControllerGetter = true
        invokedNavigationControllerGetterCount += 1
        return stubbedNavigationController
    }

    var invokedShowPickerController = false
    var invokedShowPickerControllerCount = 0

    func showPickerController() {
        invokedShowPickerController = true
        invokedShowPickerControllerCount += 1
    }

    var invokedDismissPickerController = false
    var invokedDismissPickerControllerCount = 0

    func dismissPickerController() {
        invokedDismissPickerController = true
        invokedDismissPickerControllerCount += 1
    }

    var invokedPopNavToLogin = false
    var invokedPopNavToLoginCount = 0

    func popNavToLogin() {
        invokedPopNavToLogin = true
        invokedPopNavToLoginCount += 1
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
