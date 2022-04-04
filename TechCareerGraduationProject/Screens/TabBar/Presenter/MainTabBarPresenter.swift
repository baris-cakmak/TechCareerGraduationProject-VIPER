//
//  MainTabBarPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import Foundation

class MainTabBarPresenter: ViewToPresenterMainTabBarProtocol {
    var view: PresenterToViewMainTabBarProtocol?
    
    var interactor: PresenterToInteractorMainTabBarProtocol?
    
    var router: PresenterToRouterMainTabBarProtocol?
    
    var mealViewModel: MealViewModel?
    
    func viewWillAppear() {
        getItemsAtTheCart()
    }
    
    func getItemsAtTheCart() {
        interactor?.getMealsAtTheCart()
    }
    
    
}

// MARK: - Interactor To Presenter

extension MainTabBarPresenter: InteractorToPresenterMainTabBarProtocol {
    func didMealsAtTheCartFetchedSuccessfully(_ response: MealCartResponseModel) {
        let badgeText = response.mealCart.count == 0 ? nil : "\(response.mealCart.count)"
        view?.updateBadgeValueOfCartTabBar(badgeText)
    }
    func didErrorOccured(error: Error) {
        print("debug: error is \(error)")
    }
    
    
}
