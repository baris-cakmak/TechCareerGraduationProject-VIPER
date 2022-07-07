//
//  HomeInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation
import DependencyManagerKit
import MealApiKit
import UserStorageManagerKit

protocol HomeInteractorInterface {
    func getAllMeals()
    func fetchMealsAtTheCart()
}

final class HomeInteractor: HomeInteractorInterface {
    weak var presenter: HomeInteractorOutputInterface?
    
    @Dependency private var mealNetworkManager: MealsAPINetworkable
    @Dependency private var userStorageManager: UserStorageManagerable
    
    private lazy var username = userStorageManager.getUserEmailForMealAPI()
}
// MARK: - Method
extension HomeInteractor {
    func getAllMeals() {
        mealNetworkManager.getAllMeals { [presenter] result in
            presenter?.handleFetchingAllMeals(result: result)
        }
    }
    
    func fetchMealsAtTheCart() {
        mealNetworkManager.getMealAtTheCart(username: username) { [presenter] result in
            presenter?.handleMealsAtTheCart(result: result)
        }
    }
}
