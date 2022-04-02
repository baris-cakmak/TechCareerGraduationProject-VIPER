//
//  LoginPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation

class LoginPresenter: ViewToPresenterLoginProtocol {

    weak var view: PresenterToViewLoginProtocol?
    
    var interactor: PresenterToInteractorLoginProtocol?
    
    var router: PresenterToRouterLoginProtocol?
    
    
    // MARK: - Method
    
    func didUserTappedToLogIn(email: String?,password: String?) {
        guard let email = email,
              let password = password,
              !email.isEmpty,
              !password.isEmpty
        else {
            router?.showAlert(title: "Field Error", message: "Fields Can Not Be Empty")
            return
        }
        view?.showLoadingAnimation()
        interactor?.logUserIn(email: email, password: password)

    }
    
    func didUserTappedToSignUp() {
        router?.showSignUpPage()
    }
    
}

// MARK: - Interactor To Presenter

extension LoginPresenter: InteractorToPresenterLoginProtocol {
    
    func didErrorOccuredInLogin(error: Error) {
        view?.removeAnimation()
        router?.showAlert(title: "Error", message: error.localizedDescription)
    }
    
    
    func didLogInSuccessfully() {
        view?.removeAnimation()
        router?.changeWindowAsMainTab()
    }
    
}
