//
//  HomeRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit


class HomeRouter: PresenterToRouterHomeProtocol {
  
    weak var navigationController: UINavigationController?
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    static func createModule(using navigationController: UINavigationController) -> UIViewController {
        let mealNetworkManager = MealsNetworkAPIManager()
        let view = HomeViewController.instantiate(with: .home)
        let presenter = HomePresenter()
        let interactor = HomeInteractor(mealsNetworkManager: mealNetworkManager)
        let router = HomeRouter(navigationController: navigationController)
        view.presenter = presenter
        view.presenter?.interactor = interactor
        view.presenter?.router = router
        view.presenter?.interactor?.presenter = presenter
        view.presenter?.view = view
        return view
    }
    
    func showHomeDetail(with meal: MealViewModel) {
        
        let homeDetail = HomeDetailRouter.createModule(using: navigationController!, mealViewModel: meal)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(homeDetail, animated: true)

        }
    }
    
    func showErrorPopUp(message: String) {
        let ac = UIAlertController(title: "Error Occured", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController!.present(ac,animated: true)
        }
    }
    
    
}
