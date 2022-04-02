//
//  CartInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import Foundation

class CartInteractor : PresenterToInteractorCartProtocol {

    let mealsNetworkManager: MealsAPINetworkable?
    
    init(mealsNetworkManager: MealsAPINetworkable) {
        self.mealsNetworkManager = mealsNetworkManager
    }
    
    // MARK: - Entities
    
    var mealsAtTheCartResponseModel: MealCartResponseModel?


    var presenter: InteractorToPresenterCartProtocol?
    
    
    // MARK: - Methods
    func fetchMealsAtTheCart() {
        let username = UserStorageManager.shared.getUserEmailForMealAPI()
        mealsNetworkManager?.getMealAtTheCart(username: username, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let mealsAtTheCartResponse):
                self.mealsAtTheCartResponseModel = mealsAtTheCartResponse
                self.presenter?.didFetchMealsAtTheCartSuccessfully(mealsAtTheCartResponse)
            case .failure(let error):
                self.presenter?.didErrorOccured(error: error)
            }
        })
    }
    
    func deleteSingleMeal(of mealDeleteRequestModel: MealDeleteRequestModel, at indexPath: IndexPath) {
        mealsNetworkManager?.deleteMealFromTheCart(mealDeleteRequestModel: mealDeleteRequestModel, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.presenter?.didDeleteSuccessfully(at: indexPath)
            case .failure(let error):
                self.presenter?.didErrorOccured(error: error)
            }
        })
    }
    
    func deleteAllMeals(of mealDeleteRequestModel: MealDeleteRequestModel) {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        mealsNetworkManager?.deleteMealFromTheCart(mealDeleteRequestModel: mealDeleteRequestModel, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                dispatchGroup.leave()
            
            case .failure(let error):
                self.presenter?.didErrorOccured(error: error)
            }
        })
        dispatchGroup.notify(queue: .main) {
            self.presenter?.didAllDeleteRequestsFinished()
        }
    }
    
    
    
    
}
