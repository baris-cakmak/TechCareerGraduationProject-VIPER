//
//  RegisterInteractoro.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import CommonKit
import DependencyManagerKit
import UserManagerKit

protocol RegisterInteractorInterface {
    func registerUser(with credentials: AuthCredentials)
}
final class RegisterInteractor: RegisterInteractorInterface {
    weak var presenter: RegisterInteractorOutputInterface?
    
    @Dependency private var userManager: UserManagerProvider
}
// MARK: - Method
extension RegisterInteractor {
    func registerUser(with credentials: AuthCredentials) {
        userManager.registerUser(withCredentials: credentials) { [presenter] result in
            presenter?.handleRegistration(result: result)
        }
    }
}
