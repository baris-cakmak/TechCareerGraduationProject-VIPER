//
//  MockCartRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 16.06.2022.
//

import UIKit
@testable import CartModule

final class MockCartRouter: CartRouterInterface {

    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController? {
        invokedNavigationControllerGetter = true
        invokedNavigationControllerGetterCount += 1
        return stubbedNavigationController
    }

    var invokedShowFirstTabToAddMeal = false
    var invokedShowFirstTabToAddMealCount = 0

    func showFirstTabToAddMeal() {
        invokedShowFirstTabToAddMeal = true
        invokedShowFirstTabToAddMealCount += 1
    }

    var invokedShowOrderDecisionPopUp = false
    var invokedShowOrderDecisionPopUpCount = 0

    func showOrderDecisionPopUp() {
        invokedShowOrderDecisionPopUp = true
        invokedShowOrderDecisionPopUpCount += 1
    }

    var invokedShowDeleteDecisionPopUp = false
    var invokedShowDeleteDecisionPopUpCount = 0

    func showDeleteDecisionPopUp() {
        invokedShowDeleteDecisionPopUp = true
        invokedShowDeleteDecisionPopUpCount += 1
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
