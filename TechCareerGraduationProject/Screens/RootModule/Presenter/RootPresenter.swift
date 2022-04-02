//
//  RootPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import Foundation

class RootPresenter: ViewToPresenterRootProtocol {
    
    var router: PresenterToRouterRootProtocol?
    
    var interactor: PresenterToInteractorRootProtocol?
    
    func viewWillAppear() {
        interactor?.checkOnboardingSeen()
    }
}
// MARK: - Interactor To Presenter

extension RootPresenter: InteractorToPresenterRootProtocol {
    
    func showOnboardingModule() {
        router?.changeWindowAsOnboarding()
    }
    
    func showLoginModule() {
        router?.changeWindowAsLoginModule()
    }
        
    func showTabBarModule() {
        router?.changeWindowAsTabBarModule()
    }
    
    
    
}
