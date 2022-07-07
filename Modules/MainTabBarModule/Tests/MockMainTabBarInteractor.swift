//
//  MockMainTabBarInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 19.06.2022.
//

import Foundation
@testable import MainTabBarModule

final class MockMainTabBarInteractor: MainTabBarInteractorInterface {

    var invokedGetMealsAtTheCart = false
    var invokedGetMealsAtTheCartCount = 0

    func getMealsAtTheCart() {
        invokedGetMealsAtTheCart = true
        invokedGetMealsAtTheCartCount += 1
    }
}
