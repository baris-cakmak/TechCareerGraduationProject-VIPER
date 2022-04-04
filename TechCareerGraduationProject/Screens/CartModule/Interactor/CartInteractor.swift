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

    let username = UserStorageManager.shared.getUserEmailForMealAPI()

    var presenter: InteractorToPresenterCartProtocol?
    
    
    // MARK: - Methods
    func fetchMealsAtTheCart() {
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
    

    func deleteAllMeals(of mealDeleteRequestModel: MealDeleteRequestModel, dispatchGroup: DispatchGroup) {
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()

        mealsNetworkManager?.deleteMealFromTheCart(mealDeleteRequestModel: mealDeleteRequestModel, completion: { [weak self] result in

            guard let self = self else { return }
            switch result {
            case .success(_):
                print("done")
            case .failure(let error):
                self.presenter?.didErrorOccured(error: error)
            }
            dispatchGroup.leave()

        })
//        dispatchGroup.notify(queue: .main) {
//            self.presenter?.didAllDeleteRequestsFinished()
//        }

    }

    func fetchMealsAtTheCartForBadgeValue() {
        mealsNetworkManager?.getMealAtTheCart(username: username, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let mealsAtTheCartResponse):
                self.presenter?.didFetchMealsAtTheCartForBadge(mealsAtTheCartResponse)
            case .failure(let error):
                print("debug: error in cart interactor due to", error)
            }
        })
    }
    
    
}
