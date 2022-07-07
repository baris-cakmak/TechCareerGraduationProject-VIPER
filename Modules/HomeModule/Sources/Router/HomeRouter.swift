//
//  HomeRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit
import CommonKit
import DependencyManagerKit
import HomeModuleInterface
import HomeDetailModuleInterface

protocol HomeRouterInterface: AlertPresentable {
    func showHomeDetail(with mealViewModel: MealViewModel)
}

public final class HomeRouter: HomeModuleInterface {
    weak public private(set) var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func createModule(using navigationController: UINavigationController?) -> UIViewController {
        let view = HomeViewController.instantiate(with: .home, bundle: .module)
        let interactor = HomeInteractor()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

// MARK: - Method
extension HomeRouter: HomeRouterInterface {
    func showHomeDetail(with mealViewModel: MealViewModel) {
        @Dependency var homeDetailModule: HomeDetailModuleInterface
        let homeDetailView = homeDetailModule.createModule(using: navigationController, homeDetailViewModel: .init(mealName: mealViewModel.mealName, mealImageUrl: mealViewModel.mealImageUrl, mealPrice: mealViewModel.mealPrice, mealDesc: mealViewModel.mealDesc))
        navigationController?.pushViewController(homeDetailView, animated: true)
    }
}
// MARK: - Alert Presentable
extension HomeRouter: AlertPresentable {
}
