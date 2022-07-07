//
//  RootPresenter.swift
//  RootModule
//
//  Created by Peace on 21.06.2022.
//

import Foundation
import CommonKit
import DependencyManagerKit
import UserStorageManagerKit

protocol RootPresenterInterface {
    func viewWillAppear()
}
protocol RootInteractorOutputInterface: AnyObject {
    func showOnboardingModule()
    func handleUserLoggedIn(result: Result<UserInfo, Error>)
}

final class RootPresenter: RootPresenterInterface {
    private weak var view: RootPresenterOutputInterface?
    private let interactor: RootInteractorInterface?
    private let router: RootRouterInterface?
    
    private let userStorageManager: UserStorageManagerable?

    init(
        view: RootPresenterOutputInterface,
        interactor: RootInteractorInterface?,
        router: RootRouterInterface?,
        userStorageManager: UserStorageManagerable?
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.userStorageManager = userStorageManager
    }
}
// MARK: - Method
extension RootPresenter {
    func viewWillAppear() {
        view?.configureGlobalNavigationAppereance()
        interactor?.checkOnboardingSeen()
    }
}
// MARK: - Interactor Output
extension RootPresenter: RootInteractorOutputInterface {
    func handleUserLoggedIn(result: Result<UserInfo, Error>) {
        switch result {
        case .success(let userInfo):
            userStorageManager?.setUserEmailForMealAPI(username: userInfo.email)
            router?.changeWindowAsTabBarModule()

        case .failure(let error):
            print(error.localizedDescription)
            router?.changeWindowAsLoginModule()
        }
    }
    
    func showOnboardingModule() {
        router?.changeWindowAsOnboarding()
    }
}
