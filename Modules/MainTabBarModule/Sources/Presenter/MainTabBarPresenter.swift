//
//  MainTabBarPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import Foundation
import CommonKit

protocol MainTabBarPresenterInterface {
    func viewWillAppear()
}

final class MainTabBarPresenter: MainTabBarPresenterInterface {
    weak private var view: MainTabBarPresenterOutputInterface?
    private let interactor: MainTabBarInteractorInterface?
    private let router: MainTabBarRouterInterface?
        
    init(
        view: MainTabBarPresenterOutputInterface?,
        interactor: MainTabBarInteractorInterface?,
        router: MainTabBarRouterInterface?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: - View To Presenter
extension MainTabBarPresenter {
    func viewWillAppear() {
        interactor?.getMealsAtTheCart()
        view?.configureTabBarAppeareance()
        view?.configureViewControllers()
    }
}

// MARK: - Interactor To Presenter
protocol MainTabBarInteractorOutputInterface: AnyObject {
    func handleMealsAtTheCart(result: Result<MealCartResponseModel, Error>)
}

extension MainTabBarPresenter: MainTabBarInteractorOutputInterface {
    func handleMealsAtTheCart(result: Result<MealCartResponseModel, Error>) {
        switch result {
        case .success(let mealCartResponseModel):
            let badgeText = mealCartResponseModel.mealCart.isEmpty ? nil : "\(mealCartResponseModel.mealCart.count)"
            view?.updateBadgeValueOfCartTabBar(badgeText)
            
        case .failure(let error):
            print("debug: error is \(error)")
        }
    }
}
