//
//  OnboardRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import UIKit
import OnboardingManagerKit
import DependencyManagerKit
import CommonKit
import OnboardingModuleInterface
import LoginModuleInterface

protocol OnboardingRouterInterface {
    func setRootViewControllerAsLogin()
}
public final class OnboardingRouter: OnboardingModuleInterface {
    weak private var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func createModule(using navigationController: UINavigationController) -> UIViewController {
        let view = OnboardingViewController.instantiate(with: .onboard, bundle: .module)
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter(navigationController: navigationController)
        let presenter = OnboardingPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Method
extension OnboardingRouter: OnboardingRouterInterface {
    func setRootViewControllerAsLogin() {
        let navigationController: UINavigationController = .init()
        @Dependency var loginModule: LoginModuleInterface
        let loginView = loginModule.createModule(using: navigationController)
        navigationController.pushViewController(loginView, animated: false)
        WindowChanger.shared.changeRootViewController(navigationController)
    }
}
