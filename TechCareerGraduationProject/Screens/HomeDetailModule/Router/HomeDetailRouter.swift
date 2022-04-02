//
//  HomeDetailRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit

class HomeDetailRouter: PresenterToRouterHomeDetailProtocol {

    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController, mealViewModel: MealViewModel) -> UIViewController {
        let mealNetworkManager = MealsNetworkAPIManager()
        let view = HomeDetailViewController.instantiate(with: .homeDetail)
        let presenter = HomeDetailPresenter()
        let interactor = HomeDetailInteractor(mealsNetworkManager: mealNetworkManager)
        view.presenter = presenter
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.presenter = presenter
        view.presenter?.view = view
        view.presenter?.router = HomeDetailRouter(navigationController: navigationController)
        view.presenter?.mealViewModel = mealViewModel
        return view
    }
    
    func popToHomeView() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)

        }
    }
    
    func showAlert(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(ac, animated: true, completion: nil)
        }
        
    }
        
}

