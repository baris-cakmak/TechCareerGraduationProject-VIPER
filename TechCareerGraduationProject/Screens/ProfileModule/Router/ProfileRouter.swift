//
//  ProfileRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit

class ProfileRouter: PresenterToRouterProfileProtocol {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {
        let userManager = UserManager()
        let view = ProfileViewController.instantiate(with: .profile)
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(userManager: userManager)
        let router = ProfileRouter(navigationController: UINavigationController(rootViewController: view))
        
        view.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        return router.navigationController!
        
    }
    // MARK: - Method
    func showAlert(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(ac, animated: true)
        }
    }
    func changeWindowAsLogin() {
        let loginVC = LoginRouter.createModule()
        sceneDelegate.changeRootViewController(loginVC, animated: true)
    }
}
