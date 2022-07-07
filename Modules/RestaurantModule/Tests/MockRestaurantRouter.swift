//
//  MockRestaurantRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 8.06.2022.
//

import UIKit
@testable import RestaurantModule

final class MockRestaurantRouter: RestaurantRouterInterface {

    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController? {
        invokedNavigationControllerGetter = true
        invokedNavigationControllerGetterCount += 1
        return stubbedNavigationController
    }

    var invokedShowHome = false
    var invokedShowHomeCount = 0

    func showHome() {
        invokedShowHome = true
        invokedShowHomeCount += 1
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
