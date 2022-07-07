//
//  RootRouter.swift
//  RootModule
//
//  Created by Peace on 21.06.2022.
//

import UIKit
import UserStorageManagerKit
import OnboardingManagerKit
import CommonKit
import RootModuleInterface
import DependencyManagerKit
import LoginModuleInterface
import OnboardingModuleInterface
import MainTabBarModuleInterface

protocol RootRouterInterface {
    func changeWindowAsLoginModule()
    func changeWindowAsTabBarModule()
    func changeWindowAsOnboarding()
}

public final class RootRouter: RootModuleInterface {
    public init() {}
    public func createModule(using navigationController: UINavigationController?) -> UIViewController {
        @Dependency var onboardingManager: OnboardingManagerable
        @Dependency var userStorageManager: UserStorageManagerable
        let view = RootViewController()
        let interactor = RootInteractor()
        let router = RootRouter()
        let presenter = RootPresenter(
            view: view,
            interactor: interactor,
            router: router,
            userStorageManager: userStorageManager
        )
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

extension RootRouter: RootRouterInterface {
    func changeWindowAsLoginModule() {
        let navigationController: UINavigationController = .init()
        @Dependency var loginModule: LoginModuleInterface
        let loginView = loginModule.createModule(using: navigationController)
        navigationController.pushViewController(loginView, animated: false)
        WindowChanger.shared.changeRootViewController(navigationController)
    }
    
    func changeWindowAsTabBarModule() {
        @Dependency var mainTabBarModule: MainTabBarModuleInterface
        let tabBarView = mainTabBarModule.createModule()
        WindowChanger.shared.changeRootViewController(tabBarView)
    }
    
    func changeWindowAsOnboarding() {
        let navigationController: UINavigationController = .init()
        @Dependency var onboardingModule: OnboardingModuleInterface
        let onboardingView = onboardingModule.createModule(using: navigationController)
        navigationController.pushViewController(onboardingView, animated: false)
        WindowChanger.shared.changeRootViewController(onboardingView)
    }
}
