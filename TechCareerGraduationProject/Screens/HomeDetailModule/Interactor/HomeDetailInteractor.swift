//
//  HomeDetailInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import Foundation

class HomeDetailInteractor: PresenterToInteractorHomeDetailProtocol {
    

    // MARK: - Entities
    var requestModel: MealAddToCartRequestModel?
    var mealSuccessResponseModel: MealSuccessResponseModel?
    var mealsAtTheCartResponseModel: MealCartResponseModel?

    
    // MARK: - Managers
    
    private let mealsNetworkManager: MealsAPINetworkable?
    
    
    init(mealsNetworkManager: MealsAPINetworkable) {
        self.mealsNetworkManager = mealsNetworkManager
    }
    // MARK: - Presenter
    
    weak var presenter: InteractorToPresenterHomeDetailProtocol?
    
    // MARK: - Methods
    
    func addMealsToCart() {
        guard let requestModel = requestModel else {
            return
        }

        mealsNetworkManager?.addMealToCart(addToCartRequestModel: requestModel, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let mealResponseModel):
                self.mealSuccessResponseModel = mealResponseModel
                self.presenter?.didMealAddedToCart()
            case .failure(let error):
                self.presenter?.didErrorOccured(error: error)
            }
        })
    }
    
}
