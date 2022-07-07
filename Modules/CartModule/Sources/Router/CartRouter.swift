//
//  CartRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import UIKit
import CommonKit
import CartModuleInterface
import DependencyManagerKit
import UserStorageManagerKit

protocol CartRouterInterface: AlertPresentable {
    func showFirstTabToAddMeal()
    func showOrderDecisionPopUp()
    func showDeleteDecisionPopUp()
}

public final class CartRouter: CartModuleInterface {
    weak public private(set) var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    weak private var presenter: RouterToPresenterCartProtocol?
    
    public func createModule(using navigationController: UINavigationController) -> UIViewController {
        @Dependency var userStorageManager: UserStorageManagerable
        let view = CartViewController.instantiate(with: .cart, bundle: .module)
        let interactor = CartInteractor()
        let router = CartRouter(navigationController: navigationController)
        let presenter = CartPresenter(view: view, interactor: interactor, router: router, userStorageManager: userStorageManager)
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        return view
    }
}

// MARK: - Methods
extension CartRouter: CartRouterInterface {
    func showFirstTabToAddMeal() {
        let ac = UIAlertController(title: "Add Some Meals?", message: "Yes please", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        navigationController?.tabBarController?.selectedIndex = Constants.TabBar.homeTabBarIndex
        navigationController?.tabBarController?.selectedViewController?.present(ac, animated: true)
    }
    
    func showOrderDecisionPopUp() {
        let ac = UIAlertController(title: "Are You Sure to Get The Curent Order?", message: "Say yes to keep continue, Cancel to update the cart", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.presenter?.didUserDecidedToGetTheOrder()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        navigationController?.present(ac, animated: true)
    }
    
    func showDeleteDecisionPopUp() {
        let ac = UIAlertController(title: "Delete All Items In Cart?", message: "Say yes to keep continue, Cancel to update the cart", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.presenter?.didDeleteAllRequested()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        navigationController?.present(ac, animated: true)
    }
}
// MARK: - Alert Presentable
extension CartRouter: AlertPresentable {
}
