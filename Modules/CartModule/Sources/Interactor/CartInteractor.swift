//
//  CartInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import Foundation
import CommonKit
import DependencyManagerKit
import MealApiKit
import UserStorageManagerKit

protocol CartInteractorInterface {
    func fetchMealsAtTheCart()
    func deleteSingleMeal(of mealDeleteRequestModel: MealDeleteRequestModel, at indexPath: IndexPath)
    func deleteAllMeals(of mealDeleteRequestModel: MealDeleteRequestModel, dispatchGroup: DispatchGroup)
    func fetchMealsAtTheCartForBadgeValue()
}

final class CartInteractor: CartInteractorInterface {
    weak var presenter: CartInteractorOutputInterface?
    
    @Dependency private var mealNetworkManager: MealsAPINetworkable
    @Dependency private var userStorageManager: UserStorageManagerable
    
    private lazy var username = userStorageManager.getUserEmailForMealAPI()
    
//    let mealsNetworkManager: MealsAPINetworkable?
//
//    init(mealsNetworkManager: MealsAPINetworkable) {
//        self.mealsNetworkManager = mealsNetworkManager
//    }
//
//    let username = UserStorageManager.shared.getUserEmailForMealAPI()
}
// MARK: - Method
extension CartInteractor {
    func fetchMealsAtTheCart() {
        mealNetworkManager.getMealAtTheCart(username: username) { [presenter] result in
            presenter?.didFetchMealsAtTheCart(result: result)
        }
    }
    
    func deleteSingleMeal(of mealDeleteRequestModel: MealDeleteRequestModel, at indexPath: IndexPath) {
        mealNetworkManager.deleteMealFromTheCart(mealDeleteRequestModel: mealDeleteRequestModel) { [presenter] result in
            presenter?.didDeleteMeals(result: result, at: indexPath)
        }
    }
    
    func deleteAllMeals(of mealDeleteRequestModel: MealDeleteRequestModel, dispatchGroup: DispatchGroup) {
        mealNetworkManager.deleteMealFromTheCart(mealDeleteRequestModel: mealDeleteRequestModel) { result in
            switch result {
            case .success:
                debugPrint("done")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
    }
    
    func fetchMealsAtTheCartForBadgeValue() {
        mealNetworkManager.getMealAtTheCart(username: username) { [presenter] result in
            presenter?.didFetchMealsAtTheCartForBadge(result: result)
        }
    }
}
