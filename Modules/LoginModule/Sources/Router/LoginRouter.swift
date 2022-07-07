//
//  LoginRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit
import CommonKit
import UserManagerKit
import DependencyManagerKit
import SignInValidatorKit
import LoginModuleInterface
import MainTabBarModuleInterface
import RegisterModuleInterface

protocol LoginRouterInterface: AlertPresentable {
    func showSignUpPage()
    func changeWindowAsMainTab()
}

public final class LoginRouter: LoginModuleInterface {
    weak public private(set) var navigationController: UINavigationController?

    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    public func createModule(using navigationController: UINavigationController) -> UIViewController {
        @Dependency var signInValidator: SignInValidatorInterface
        let view = LoginViewController.instantiate(with: .login, bundle: .module)
        let interactor = LoginInteractor()
        let router = LoginRouter(navigationController: navigationController)
        let presenter = LoginPresenter(
            view: view,
            interactor: interactor,
            router: router,
            signInValidator: signInValidator
        )
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Method
extension LoginRouter: LoginRouterInterface {
    func showSignUpPage() {
        guard let navigationController = navigationController else {
            return
        }
        @Dependency var registerModule: RegisterModuleInterface
        let registerView = registerModule.createModule(using: navigationController)
        navigationController.pushViewController(registerView, animated: true)
    }
    func changeWindowAsMainTab() {
        @Dependency var mainTabBarModule: MainTabBarModuleInterface
        let mainTabBarView = mainTabBarModule.createModule()
        WindowChanger.shared.changeRootViewController(mainTabBarView)
    }
}
