//
//  MockHomeInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 9.06.2022.
//

import Foundation
@testable import HomeModule

final class MockHomeInteractor: HomeInteractorInterface {

    var invokedGetAllMeals = false
    var invokedGetAllMealsCount = 0

    func getAllMeals() {
        invokedGetAllMeals = true
        invokedGetAllMealsCount += 1
    }

    var invokedFetchMealsAtTheCart = false
    var invokedFetchMealsAtTheCartCount = 0

    func fetchMealsAtTheCart() {
        invokedFetchMealsAtTheCart = true
        invokedFetchMealsAtTheCartCount += 1
    }
}

