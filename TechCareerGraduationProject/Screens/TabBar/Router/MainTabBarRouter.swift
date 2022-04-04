//
//  MainTabBarRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import UIKit

class MainTabBarRouter: PresenterToRouterMainTabBarProtocol {
    
    static func createModule() -> UIViewController {
        let mealNetworkManager = MealsNetworkAPIManager()
        let view = MainTabBarController()
        let presenter = MainTabBarPresenter()
        let interactor = MainTabBarIntereactor(mealsNetworkManager: mealNetworkManager)
        let router = MainTabBarRouter()
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    

}
