//
//  MainTabBarInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import Foundation

class MainTabBarIntereactor: PresenterToInteractorMainTabBarProtocol {

    var mealsAtTheCartResponseModel: MealCartResponseModel?
    
    var presenter: InteractorToPresenterMainTabBarProtocol?
    
    var mealsNetworkManager: MealsAPINetworkable?
    
    init(mealsNetworkManager: MealsAPINetworkable?) {
        self.mealsNetworkManager = mealsNetworkManager
    }
    
 
    func getMealsAtTheCart() {
        let username = UserStorageManager.shared.getUserEmailForMealAPI()
        mealsNetworkManager?.getMealAtTheCart(username: username, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let mealsAtTheCartResponse):
                self.mealsAtTheCartResponseModel = mealsAtTheCartResponse
                self.presenter?.didMealsAtTheCartFetchedSuccessfully(mealsAtTheCartResponse)
            case .failure(let error):
                self.presenter?.didErrorOccured(error: error)
            }
        })
        
        
    }

    
    
}
