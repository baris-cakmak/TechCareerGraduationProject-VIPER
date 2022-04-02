//
//  LoginInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation

class LoginInteractor: PresenterToInteractorLoginProtocol {
    
    weak var presenter: InteractorToPresenterLoginProtocol?

    let userManager: UserManagerProvider?
    
    init(userManager: UserManagerProvider) {
        self.userManager = userManager
    }
    
    
    // MARK: - Method
    
    func logUserIn(email: String, password: String) {
        userManager?.logUserIn(with: email, and: password, completion: {[weak self] dataResult, error in
            guard let self = self else { return }
            if let error = error {
                self.presenter?.didErrorOccuredInLogin(error: error)
            }
            guard let dataResult = dataResult else { return }
            UserStorageManager.shared.setUserEmailForMealAPI(username: dataResult.user.email!)
            self.presenter?.didLogInSuccessfully()
        })
    }
    
    
}
