//
//  LoginRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit


class LoginRouter: PresenterToRouterLoginProtocol {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    static func createModule() -> UINavigationController {
        let userManager = UserManager()
        let view = LoginViewController.instantiate(with: .login)
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(userManager: userManager)
        let router = LoginRouter(navigationController: UINavigationController(rootViewController: view))
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        
        return router.navigationController!
    }
    
    
    // MARK: - Method
    
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(ac,animated: true)
        }
        
    }
    
    func showSignUpPage() {
        let registerVC = RegisterRouter.createModule(using: navigationController!)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    func changeWindowAsMainTab() {
        let mainTabBarModule = MainTabBarRouter.createModule()
        DispatchQueue.main.async {
            sceneDelegate.changeRootViewController(mainTabBarModule)
        }
    }
    
}
