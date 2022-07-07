//
//  MockHomeDetailInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 14.06.2022.
//

import Foundation
@testable import HomeDetailModule
@testable import CommonKit

final class MockHomeDetailInteractor: HomeDetailInteractorInterface {

    var invokedRequestModelSetter = false
    var invokedRequestModelSetterCount = 0
    var invokedRequestModel: MealAddToCartRequestModel?
    var invokedRequestModelList = [MealAddToCartRequestModel?]()
    var invokedRequestModelGetter = false
    var invokedRequestModelGetterCount = 0
    var stubbedRequestModel: MealAddToCartRequestModel!

    var requestModel: MealAddToCartRequestModel? {
        set {
            invokedRequestModelSetter = true
            invokedRequestModelSetterCount += 1
            invokedRequestModel = newValue
            invokedRequestModelList.append(newValue)
        }
        get {
            invokedRequestModelGetter = true
            invokedRequestModelGetterCount += 1
            return stubbedRequestModel
        }
    }

    var invokedAddMealsToCart = false
    var invokedAddMealsToCartCount = 0

    func addMealsToCart() {
        invokedAddMealsToCart = true
        invokedAddMealsToCartCount += 1
    }
}
