//
//  ProfileRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit
import CommonKit
import DependencyManagerKit
import LoginModuleInterface
import ProfileModuleInterface

protocol ProfileRouterInterface: AlertPresentable {
    func changeWindowAsLogin()
}

public final class ProfileRouter: ProfileModuleInterface {
    weak public private(set) var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func createModule(using navigationController: UINavigationController) -> UIViewController {
        let view = ProfileViewController.instantiate(with: .profile, bundle: .module)
        let interactor = ProfileInteractor()
        let router = ProfileRouter(navigationController: navigationController)
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Method
extension ProfileRouter: ProfileRouterInterface {
    func changeWindowAsLogin() {
        let navigationController: UINavigationController = .init()
        @Dependency var loginModule: LoginModuleInterface
        let view = loginModule.createModule(using: navigationController)
        navigationController.pushViewController(view, animated: true)
        WindowChanger.shared.changeRootViewController(navigationController)
    }
}
