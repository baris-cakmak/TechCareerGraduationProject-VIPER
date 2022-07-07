//
//  ProfilePresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import Foundation
import CommonKit

protocol ProfilePresenterInterface {
    func viewDidLoad()
    func didTapToLogout()
    func handleError(_ error: Error)
}

final class ProfilePresenter: ProfilePresenterInterface {
    weak private var view: ProfilePresenterOutputInterface?
    private let interactor: ProfileInteractorInterface?
    private let router: ProfileRouterInterface?
    private var profileViewModel: ProfileViewModel = .init()
    
    // MARK: - Init
    init(
        view: ProfilePresenterOutputInterface?,
        interactor: ProfileInteractorInterface?,
        router: ProfileRouterInterface?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: - View To Presenter
extension ProfilePresenter {
    func viewDidLoad() {
        view?.configureProfilePhoto()
        view?.configureRightBarButtonItem()
        view?.setNavigationItemTitle(with: Constants.NavigationItem.profileTitle)
        view?.configureAnimation()
        interactor?.fetchUser()
    }
    func didTapToLogout() {
        interactor?.logoutTheUser()
    }
    func handleError(_ error: Error) {
        router?.showAlert(message: error.localizedDescription)
    }
}

// MARK: - Interactor To Presenter
protocol InteractorOutputRegisterInterface: AnyObject {
    func handleFetchUser(result: Result<UserInfo, Error>)
    func handleLogOutUser(result: Result<Void, Error>)
}

extension ProfilePresenter: InteractorOutputRegisterInterface {
    func handleFetchUser(result: Result<UserInfo, Error>) {
        view?.removeAnimation()
        switch result {
        case .success(let user):

            if let imageURL = URL(string: user.profileImageURL) {
                profileViewModel = .init(
                    email: user.email,
                    username: user.username,
                    profileImage: imageURL
                )
                
                view?.updateView(with: profileViewModel)
            } else {
                profileViewModel = .init(email: user.email, username: user.username, profileImage: .string(Constants.MealApi.somethingWentWrongUrl))
                view?.updateView(with: profileViewModel)
            }
            
        case .failure(let error):
            handleError(error)
        }
    }
    func handleLogOutUser(result: Result<Void, Error>) {
        switch result {
        case .success:
            router?.changeWindowAsLogin()
            
        case .failure(let error):
            handleError(error)
        }
    }
}
