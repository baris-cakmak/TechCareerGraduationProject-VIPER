//
//  LoginPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import CommonKit
import SignInValidatorKit
import DependencyManagerKit

protocol LoginPresenterInterface: KeyboardPresentable {
    func viewDidLoad()
    func didUserTappedToLogIn(email: String?, password: String?)
    func didUserTappedToSignUp()
}

final class LoginPresenter: LoginPresenterInterface {
    weak private var view: LoginPresenterOutputInterface?
    private let interactor: LoginInteractorInterface?
    private let router: LoginRouterInterface?
    
    private var signInValidator: SignInValidatorInterface?
    
    init(
        view: LoginPresenterOutputInterface?,
        interactor: LoginInteractorInterface?,
        router: LoginRouterInterface?,
        signInValidator: SignInValidatorInterface?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.signInValidator = signInValidator
    }
}
// MARK: - View To Presenter
extension LoginPresenter {
    func viewDidLoad() {
        view?.configureKeyboardNotifications()
        view?.setupTextFieldDelegates()
        view?.configureTapGesture()
    }
    func didUserTappedToLogIn(email: String?, password: String?) {
        guard let email = email,
            let password = password
        else {
            router?.showAlert(message: SignInErrors.missingField.localizedDescription)
            return
        }
        signInValidator?.signInModel = .init(email: email, password: password)
        do {
            try signInValidator?.validateAll()
        } catch {
            router?.showAlert(message: error.localizedDescription)
            return
        }
        view?.configureAnimation()
        interactor?.logUserIn(email: email, password: password)
    }
    func didUserTappedToSignUp() {
        router?.showSignUpPage()
    }
}
// MARK: - Interactor To Presenter

protocol LoginInteractorOutputInterface: AnyObject {
    func handleLoginAttempt(result: Result<Void, Error>)
}

extension LoginPresenter: LoginInteractorOutputInterface {
    func handleLoginAttempt(result: Result<Void, Error>) {
        view?.removeAnimation()
        switch result {
        case .success:
            router?.changeWindowAsMainTab()
            
        case .failure(let error):
            router?.showAlert(message: error.localizedDescription)
        }
    }
}
// MARK: - Keyboard Presentable
extension LoginPresenter: KeyboardPresentable {
    func changeOriginYPointOfView(with yValue: Float, hideBackButton: Bool, animated: Bool) {
        view?.setOriginYPointOfTheView(with: yValue)
        view?.hideNavigationItemBackButtonItem(hideBackButton, animated: animated)
    }

    func moveBackToDefaultYPoint(hideBackButton: Bool, animated: Bool) {
        view?.setOriginYPointOfTheView(with: 0)
        view?.hideNavigationItemBackButtonItem(hideBackButton, animated: animated)
    }
}
