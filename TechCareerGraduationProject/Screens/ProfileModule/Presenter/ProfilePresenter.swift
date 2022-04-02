//
//  ProfilePresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import Foundation

class ProfilePresenter: ViewToPresenterProfileProtocol {
    
    var view: PresenterToViewProfileProtocol?
    
    var interactor: PresenterToInteractorProfileProtocol?
    
    var router: PresenterToRouterProfileProtocol?
    
    var profileViewModel: ProfileViewModel?
    
    func viewDidLoad() {
        view?.configureAnimation()
        interactor?.fetchUser()

    }
    func didTapToLogout() {
        interactor?.logoutTheUser()
    }
}
// MARK: - Interactor To Presenter

extension ProfilePresenter: InteractorToPresenterProfileProtocol {
    
    func didfetchUser(_ user: User) {
        view?.removeAnimation()
        profileViewModel = ProfileViewModel(email: user.email, username: user.username, profileImage: URL(string: user.profileImageURL)!)
        view?.updateView(with: profileViewModel!)
    }
    
    func didErrorOccured(_ error: Error) {
        view?.removeAnimation()
        
        router?.showAlert(message: error.localizedDescription)
    }
    
    func didUserLogout() {
        router?.changeWindowAsLogin()

    }
    
}
