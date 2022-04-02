//
//  RootInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import Foundation
import FirebaseAuth

class RootInteractor: PresenterToInteractorRootProtocol {
    
    
    weak var presenter: InteractorToPresenterRootProtocol?
    
    var onboardingManager: OnboardingManagerable?
    

    init(onboardingManager: OnboardingManagerable) {
        self.onboardingManager = onboardingManager
    }
    
    // MARK: - Method
    func checkUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            presenter?.showLoginModule()
        } else {
            UserStorageManager.shared.setUserEmailForMealAPI(username: Auth.auth().currentUser!.email!)
            presenter?.showTabBarModule()
        }
        
    }
    func checkOnboardingSeen() {
        // test purpose -> uncheck
//        onboardingManager?.resetOnboardingSeen()
        onboardingManager?.getOnboardingSeen() ?? false ? checkUserIsLoggedIn() : presenter?.showOnboardingModule()
    }
}
