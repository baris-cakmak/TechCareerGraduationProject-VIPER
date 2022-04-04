//
//  CartRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import UIKit

class CartRouter: PresenterToRouterCartProtocol {

    
    let navigationController: UINavigationController?
    
    weak var presenter: RouterToPresenterCartProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {
        let mealsNetworkManager = MealsNetworkAPIManager()
        let view = CartViewController.instantiate(with: .cart)
        let interactor = CartInteractor(mealsNetworkManager: mealsNetworkManager)
        let presenter = CartPresenter()
        let router = CartRouter(navigationController: UINavigationController(rootViewController: view))
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.interactor?.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.presenter = presenter
        return router.navigationController!
        
    }
    
    func showFirstTabToAddMeal() {
        let ac = UIAlertController(title: "Add Some Meals?", message: "Yes please", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.tabBarController?.selectedIndex = Constants.homeTabBarIndex
            self.navigationController?.tabBarController?.selectedViewController?.present(ac, animated: true)
        }
    }
    
    func showOrderDecisionPopUp() {
        let ac = UIAlertController(title: "Are You Sure to Get The Curent Order?", message: "Say yes to keep continue, Cancel to update the cart", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: {[weak self] _ in
            self?.presenter?.didUserDecidedToGetTheOrder()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(ac,animated: true)
        }
        
    }
    
    func showDeleteDecisionPopUp() {
        let ac = UIAlertController(title: "Delete All Items In Cart?", message: "Say yes to keep continue, Cancel to update the cart", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: {[weak self] _ in
            self?.presenter?.didDeleteAllRequested()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(ac,animated: true)
        }
    }
    
    
    
}
