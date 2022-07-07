//
//  HomeDetailInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import Foundation
import CommonKit
import DependencyManagerKit
import MealApiKit

protocol HomeDetailInteractorInterface {
    var requestModel: MealAddToCartRequestModel? { get set }
    func addMealsToCart()
}

final class HomeDetailInteractor: HomeDetailInteractorInterface {
    var requestModel: MealAddToCartRequestModel?
    
    @Dependency private var mealNetworkManager: MealsAPINetworkable

    // MARK: - Presenter
    weak var presenter: HomeDetailInteractorOutputInterface?
}
// MARK: - Method
extension HomeDetailInteractor {
    func addMealsToCart() {
        guard let requestModel = requestModel else {
            return
        }
        mealNetworkManager.addMealToCart(addToCartRequestModel: requestModel) { [presenter] result in
            presenter?.handleMealAddToCart(result: result)
        }
    }
}
