//
//  HomeDetailPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import Foundation

class HomeDetailPresenter: ViewToPresenterHomeDetailProtocol {


    // MARK: - Presenter Obligations

    weak var view: PresenterToViewHomeDetailProtocol?
    
    var interactor: PresenterToInteractorHomeDetailProtocol?
    
    var router: PresenterToRouterHomeDetailProtocol?
    
    // MARK: - ViewModel
    
    var mealViewModel: MealViewModel?
    
    // MARK: - Method
    
    func viewDidLoad() {
        view?.configureInitialView(viewModel: mealViewModel!)
    }
    
    func calculatePrice(by stepperValue: Double) {
        guard let mealViewModel = mealViewModel else {
            return
        }
        let price = Int(mealViewModel.mealPrice) ?? 0
        let amount = Int(stepperValue)
        let calculatedPrice = price * amount
        view?.didPriceChanged(price: "₺ \(calculatedPrice)")
        
    }
    
    func addMealsToCartInApi(orderCount: Double) {
        guard let mealViewModel = mealViewModel else {
            return
        }
        let mealPrice = Int(mealViewModel.mealPrice)!
        let username = UserStorageManager.shared.getUserEmailForMealAPI()

        interactor?.requestModel = MealAddToCartRequestModel(username: username,
                                                             orderCount: Int(orderCount),
                                                             mealPrice: mealPrice,
                                                             mealImageName: "\(mealViewModel.mealImageUrl)",
                                                             mealName: mealViewModel.mealName)
        interactor?.addMealsToCart()
    }
    func getItemsAtTheCart() {
        interactor?.getMealsAtTheCart()
    }
    

    
}
// MARK: - InteractorToPresenter

extension HomeDetailPresenter: InteractorToPresenterHomeDetailProtocol {
    
    func didMealAddedToCart() {
        router?.popToHomeView()
    }
    
    func didErrorOccured(error: Error) {
        router?.showAlert(message: error.localizedDescription)
    }
    func didMealsAtTheCartFetchedSuccessfully(_ response: MealCartResponseModel) {
        let badgeText = response.mealCart.count == 0 ? nil : "\(response.mealCart.count)"
        view?.updateBadgeValueOfCartTabBar(badgeText)
    }
    
    
}
