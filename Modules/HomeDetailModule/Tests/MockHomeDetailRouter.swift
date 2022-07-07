//
//  MockHomeDetailRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 14.06.2022.
//

import UIKit
@testable import HomeDetailModule

final class MockHomeDetailRouter: HomeDetailRouterInterface {

    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController? {
        invokedNavigationControllerGetter = true
        invokedNavigationControllerGetterCount += 1
        return stubbedNavigationController
    }

    var invokedPopToHomeView = false
    var invokedPopToHomeViewCount = 0

    func popToHomeView() {
        invokedPopToHomeView = true
        invokedPopToHomeViewCount += 1
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
