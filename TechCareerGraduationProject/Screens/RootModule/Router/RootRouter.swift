//
//  RootRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit

class RootRouter: PresenterToRouterRootProtocol {
    

    static func createModule() -> UIViewController {
        let onboardingManager = OnboardingStorageManager()
        let view = RootViewController()
        let presenter = RootPresenter()
        let interactor = RootInteractor(onboardingManager: onboardingManager)
        let router = RootRouter()
    
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    // MARK: - Method
    
    func changeWindowAsLoginModule() {
        let loginModule = LoginRouter.createModule()
        sceneDelegate.changeRootViewController(loginModule)
    }
    
    func changeWindowAsTabBarModule() {
        let tabBarModule = MainTabBarRouter.createModule()
        sceneDelegate.changeRootViewController(tabBarModule)
    }
    
    func changeWindowAsOnboarding() {
        let onboarding = OnboardingRouter.createModule()
        sceneDelegate.changeRootViewController(onboarding)
    }
}
