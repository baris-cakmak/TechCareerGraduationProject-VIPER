//
//  RestaurantRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import CommonKit
import RestaurantModuleInterface
import DependencyManagerKit
import HomeModuleInterface

protocol RestaurantRouterInterface: AlertPresentable {
    func showHome()
}
public final class RestaurantRouter: RestaurantModuleInterface {
    weak public private(set) var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func createModule(using navigationController: UINavigationController) -> UIViewController {
        let view = RestaurantViewController.instantiate(with: .restaurant, bundle: .module)
        let interactor = RestaurantInteractor()
        let router = RestaurantRouter(navigationController: navigationController)
        let presenter = RestaurantPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Methods
extension RestaurantRouter: RestaurantRouterInterface {
    func showHome() {
        @Dependency var homeModule: HomeModuleInterface
        let homeView = homeModule.createModule(using: navigationController)
        navigationController?.pushViewController(homeView, animated: true)
    }
    
    func showErrorPopUp(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        navigationController?.present(ac, animated: true)
    }
}
// MARK: - Alert Presentable
extension RestaurantRouter: AlertPresentable {
}
