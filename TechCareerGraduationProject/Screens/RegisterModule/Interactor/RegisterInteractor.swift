//
//  RegisterInteractoro.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation

class RegisterInteractor: PresenterToInteractorRegisterProtocol {
    
    var presenter: InteractorToPresenterRegisterProtocol?
    
    private let userManager: UserManagerProvider?

    init(userManager: UserManagerProvider) {
        self.userManager = userManager
    }
    
    // MARK: - Method
    
    func registerUser(with credentials: AuthCredentials) {
        userManager?.registerUser(withCredentials: credentials) { [presenter] error in
            if let error = error {
                presenter?.didErrorOccuredInRegistration(error: error)
                return
            }
            presenter?.didRegistrationComplete()
        }
    }
    
    
}
