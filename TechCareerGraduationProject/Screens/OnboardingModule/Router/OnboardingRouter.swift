//
//  OnboardRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import Foundation
import UIKit

class OnboardingRouter: PresenterToRouterOnboardingProtocol {
    
    static func createModule() -> UIViewController {
        let onboardingStorageManager = OnboardingStorageManager()
        let view = OnboardingViewController.instantiate(with: .onboarding)
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor(onboardingStorageManager: onboardingStorageManager)
        let router = OnboardingRouter()
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    
    // MARK: - Method
    
    func setRootViewControllerAsLogin() {
        let loginModule = LoginRouter.createModule()
            sceneDelegate.changeRootViewController(loginModule)
    }
}
