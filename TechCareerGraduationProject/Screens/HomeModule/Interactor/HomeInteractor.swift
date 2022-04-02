//
//  HomeInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

class HomeInteractor: PresenterToInteractorHomeProtocol {

    private let username = UserStorageManager.shared.getUserEmailForMealAPI()
    
    // MARK: - Entity
    
    var mealResponseModel: MealResponseModel?

    // MARK: - Presenter
    
    weak var presenter: InteractorToPresenterHomeProtocol?
    

    // MARK: - Managers
    
    private let mealsNetworkManager: MealsAPINetworkable?
    init(mealsNetworkManager: MealsAPINetworkable) {
        self.mealsNetworkManager = mealsNetworkManager
    }
    
    // MARK: - Methods
    
    func getAllMeals() {
        mealsNetworkManager?.getAllMeals(completion: {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let mealResponseModel):
                self.mealResponseModel = mealResponseModel
                self.presenter?.didFetchAllMealsSuccessfully(responseModel: mealResponseModel)
                
            case .failure(let error):
                
                self.presenter?.didFetchWithAnError(error: error)
            }
        })
        
        

    }
    
    func fetchMealsAtTheCart() {
        
        mealsNetworkManager?.getMealAtTheCart(username: username, completion: {[weak self] result in
            guard let self = self else { return }
            
            switch result {

            case .success(let mealsAtTheBasketResponse):
                self.presenter?.didFetchMealsAtTheCart(responseModel: mealsAtTheBasketResponse)
            case .failure(let error):
                print("debug: error is", error)
                // api returns no data when the cart is empty.
//                self.presenter?.didFetchWithAnError(error: error)
            }
        })
    }
    
}
