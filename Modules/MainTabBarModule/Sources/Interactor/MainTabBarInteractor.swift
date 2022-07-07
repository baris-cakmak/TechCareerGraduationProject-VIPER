//
//  MainTabBarInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import Foundation
import DependencyManagerKit
import MealApiKit
import UserStorageManagerKit

protocol MainTabBarInteractorInterface {
    func getMealsAtTheCart()
}

final class MainTabBarIntereactor: MainTabBarInteractorInterface {
    weak var presenter: MainTabBarInteractorOutputInterface?
    
    @Dependency private var mealNetworkManager: MealsAPINetworkable
    @Dependency private var userStorageManager: UserStorageManagerable
}
extension MainTabBarIntereactor {
    func getMealsAtTheCart() {
        let username = userStorageManager.getUserEmailForMealAPI()
        mealNetworkManager.getMealAtTheCart(username: username) { [presenter] result in
            presenter?.handleMealsAtTheCart(result: result)
        }
    }
}
