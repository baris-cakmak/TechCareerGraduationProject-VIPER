//
//  RootInteractor.swift
//  RootModule
//
//  Created by Peace on 21.06.2022.
//

import Foundation
import UserStorageManagerKit
import OnboardingManagerKit
import DependencyManagerKit
import UserManagerKit

protocol RootInteractorInterface {
    func checkOnboardingSeen()
}
final class RootInteractor {
    @Dependency private var userManager: UserManagerProvider
    @Dependency private var onboardingStorageManager: OnboardingManagerable

    weak var presenter: RootInteractorOutputInterface?
}
// MARK: - Methods
extension RootInteractor: RootInteractorInterface {
    func checkOnboardingSeen() {
        onboardingStorageManager.getOnboardingSeen() ? checkUserIsLoggedIn() : presenter?.showOnboardingModule()
    }
}
// MARK: - Helper
extension RootInteractor {
    private func checkUserIsLoggedIn() {
        userManager.fetchUser { result in
            self.presenter?.handleUserLoggedIn(result: result)
        }
    }
}
