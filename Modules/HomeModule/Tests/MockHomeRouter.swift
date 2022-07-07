//
//  MockHomeRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 9.06.2022.
//

import UIKit
@testable import HomeModule

final class MockHomeRouter: HomeRouterInterface {

    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController? {
        invokedNavigationControllerGetter = true
        invokedNavigationControllerGetterCount += 1
        return stubbedNavigationController
    }

    var invokedShowHomeDetail = false
    var invokedShowHomeDetailCount = 0
    var invokedShowHomeDetailParameters: (mealViewModel: MealViewModel, Void)?
    var invokedShowHomeDetailParametersList = [(mealViewModel: MealViewModel, Void)]()

    func showHomeDetail(with mealViewModel: MealViewModel) {
        invokedShowHomeDetail = true
        invokedShowHomeDetailCount += 1
        invokedShowHomeDetailParameters = (mealViewModel, ())
        invokedShowHomeDetailParametersList.append((mealViewModel, ()))
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
