//
//  ProfileInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import Foundation
import DependencyManagerKit
import UserManagerKit

protocol ProfileInteractorInterface {
    func fetchUser()
    func logoutTheUser()
}

final class ProfileInteractor: ProfileInteractorInterface {
    weak var presenter: InteractorOutputRegisterInterface?
    @Dependency private var userManager: UserManagerProvider
}
// MARK: - Method
extension ProfileInteractor {
    func fetchUser() {
        userManager.fetchUser { [presenter] result in
            presenter?.handleFetchUser(result: result)
        }
    }
    func logoutTheUser() {
        userManager.logOut { [presenter] result in
            presenter?.handleLogOutUser(result: result)
        }
    }
}
