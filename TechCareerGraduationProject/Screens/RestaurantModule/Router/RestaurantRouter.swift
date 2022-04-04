//
//  RestaurantRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit

class RestaurantRouter: PresenterToRouterRestaurantProtocol {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {
        let dummyNetworkManager = MyDummyRestaurantAPINetworkManager()
        let view = RestaurantViewController.instantiate(with: .restaurant)
        let presenter = RestaurantPresenter()
        let interactor = RestaurantInteractor(dummyNetworkManager: dummyNetworkManager)
        let router = RestaurantRouter(navigationController: UINavigationController(rootViewController: view))
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        return router.navigationController!
        
        
    }
    
    func showHome() {
        let homeModule = HomeRouter.createModule(using: navigationController!)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(homeModule, animated: true)
        }

    }
    
    func showErrorPopUp(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(ac, animated: true)
        }
    }
    
    
}
