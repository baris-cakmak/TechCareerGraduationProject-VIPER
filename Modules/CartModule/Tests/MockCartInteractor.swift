//
//  MockCartInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 16.06.2022.
//

import Foundation
@testable import CartModule
@testable import CommonKit

final class MockCartInteractor: CartInteractorInterface {

    var invokedFetchMealsAtTheCart = false
    var invokedFetchMealsAtTheCartCount = 0

    func fetchMealsAtTheCart() {
        invokedFetchMealsAtTheCart = true
        invokedFetchMealsAtTheCartCount += 1
    }

    var invokedDeleteSingleMeal = false
    var invokedDeleteSingleMealCount = 0
    var invokedDeleteSingleMealParameters: (mealDeleteRequestModel: MealDeleteRequestModel, indexPath: IndexPath)?
    var invokedDeleteSingleMealParametersList = [(mealDeleteRequestModel: MealDeleteRequestModel, indexPath: IndexPath)]()

    func deleteSingleMeal(of mealDeleteRequestModel: MealDeleteRequestModel, at indexPath: IndexPath) {
        invokedDeleteSingleMeal = true
        invokedDeleteSingleMealCount += 1
        invokedDeleteSingleMealParameters = (mealDeleteRequestModel, indexPath)
        invokedDeleteSingleMealParametersList.append((mealDeleteRequestModel, indexPath))
    }

    var invokedDeleteAllMeals = false
    var invokedDeleteAllMealsCount = 0
    var invokedDeleteAllMealsParameters: (mealDeleteRequestModel: MealDeleteRequestModel, dispatchGroup: DispatchGroup)?
    var invokedDeleteAllMealsParametersList = [(mealDeleteRequestModel: MealDeleteRequestModel, dispatchGroup: DispatchGroup)]()

    func deleteAllMeals(of mealDeleteRequestModel: MealDeleteRequestModel, dispatchGroup: DispatchGroup) {
        invokedDeleteAllMeals = true
        invokedDeleteAllMealsCount += 1
        invokedDeleteAllMealsParameters = (mealDeleteRequestModel, dispatchGroup)
        invokedDeleteAllMealsParametersList.append((mealDeleteRequestModel, dispatchGroup))
        dispatchGroup.leave()
    }

    var invokedFetchMealsAtTheCartForBadgeValue = false
    var invokedFetchMealsAtTheCartForBadgeValueCount = 0

    func fetchMealsAtTheCartForBadgeValue() {
        invokedFetchMealsAtTheCartForBadgeValue = true
        invokedFetchMealsAtTheCartForBadgeValueCount += 1
    }
}
