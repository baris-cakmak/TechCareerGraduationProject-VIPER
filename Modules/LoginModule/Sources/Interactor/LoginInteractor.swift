//
//  LoginInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import UserManagerKit
import DependencyManagerKit

protocol LoginInteractorInterface {
    func logUserIn(email: String, password: String)
}

final class LoginInteractor: LoginInteractorInterface {
    weak var presenter: LoginInteractorOutputInterface?
    
    @Dependency private var userManager: UserManagerProvider
}
// MARK: - Method
extension LoginInteractor {
    func logUserIn(email: String, password: String) {
        userManager.logUserIn(with: email, and: password) { [weak self] result in
            guard let self = self else {
                return
            }
            self.presenter?.handleLoginAttempt(result: result)
        }
    }
}
