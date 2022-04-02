//
//  RootContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit

protocol ViewToPresenterRootProtocol {
    var router: PresenterToRouterRootProtocol? { get set }
    var interactor: PresenterToInteractorRootProtocol? { get set }
    
    func viewWillAppear()
    
}

protocol PresenterToInteractorRootProtocol {
    var presenter: InteractorToPresenterRootProtocol? { get set }
    var onboardingManager: OnboardingManagerable? { get set }
    func checkUserIsLoggedIn()
    func checkOnboardingSeen()
}

protocol PresenterToRouterRootProtocol {
    static func createModule() -> UIViewController
    func changeWindowAsLoginModule()
    func changeWindowAsTabBarModule()
    func changeWindowAsOnboarding()
}
protocol InteractorToPresenterRootProtocol: AnyObject {
    func showLoginModule()
    func showTabBarModule()
    func showOnboardingModule()
}


