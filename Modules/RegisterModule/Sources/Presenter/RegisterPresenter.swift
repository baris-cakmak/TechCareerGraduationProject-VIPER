//
//  RegisterPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit
import CommonKit
import DependencyManagerKit
import SignUpValidatorKit

typealias RegisterpPresenterInterfaces = KeyboardPresentable

protocol RegisterPresenterInterface: RegisterpPresenterInterfaces {
    func viewDidLoad()
    func didImageSelected(_ info: [UIImagePickerController.InfoKey: Any])
    func showPicker()
    func popToLogin()
    func validateUserInputs(email: String?, password: String?, username: String?)
    func registerValidatedUser(withAuthCredentials credentials: AuthCredentials)
    func handleError(_ error: Error)
}

final class RegisterPresenter: RegisterPresenterInterface {
    weak private var view: RegisterPresenterOutputInterface?
    private let interactor: RegisterInteractorInterface?
    private let router: RegisterRouterInterface?
    
    private var signUpValidator: SignUpValidatorInterface?
    
    init(
        view: RegisterPresenterOutputInterface?,
        interactor: RegisterInteractorInterface?,
        router: RegisterRouterInterface?,
        signUpValidator: SignUpValidatorInterface?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.signUpValidator = signUpValidator
    }
    
    private(set) var profileImage: UIImage?
}
// MARK: - View To Presenter
extension RegisterPresenter {
    func viewDidLoad() {
        view?.configureSignInContainer()
        view?.configureKeyboardNotifications()
        view?.setupTextFieldDelegates()
        view?.configureTapGesture()
    }
    
    func didImageSelected(_ info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        profileImage = selectedImage
        view?.makeCircularImage()
        view?.setProfileImage(selectedImage)
        router?.dismissPickerController()
    }
    
    func showPicker() {
        router?.showPickerController()
    }
    
    func popToLogin() {
        router?.popNavToLogin()
    }
    
    func validateUserInputs(email: String?, password: String?, username: String?) {
        view?.configureAnimation(
            named: .userLoading,
            mode: . loop,
            speed: 2,
            backgroundColor: "blurBackground2",
            completion: nil
        )
        guard let email = email,
            let password = password,
            let username = username,
            let profileImage = profileImage else {
            handleError(SignUpErrors.missingField)
            return
        }
        signUpValidator?.signUpModel = .init(
            email: email,
            passwordOne: password,
            passwordTwo: password,
            username: username
        )
        
        do {
            try signUpValidator?.validateAll()
        } catch {
            handleError(error)
            return
        }

        registerValidatedUser(
            withAuthCredentials: .init(
                email: email,
                password: password,
                username: username,
                profileImage: profileImage
            )
        )
    }
    
    func registerValidatedUser(withAuthCredentials credentials: AuthCredentials) {
        interactor?.registerUser(with: credentials)
    }
    
    func handleError(_ error: Error) {
        view?.removeAnimation()
        router?.showAlert(message: error.localizedDescription)
    }
}
// MARK: - Interactor To Presenter
protocol RegisterInteractorOutputInterface: AnyObject {
    func handleRegistration(result: Result<Void, Error>)
}

extension RegisterPresenter: RegisterInteractorOutputInterface {
    func handleRegistration(result: Result<Void, Error>) {
        switch result {
        case .success:
            view?.configureAnimation(
                named: .registrationSuccess,
                mode: .playOnce,
                speed: 1.5,
                backgroundColor: "blurBackground2"
            ) { _ in
                self.view?.removeAnimation()
                self.router?.popNavToLogin()
            }
            
        case .failure(let error):
            view?.removeAnimation()
            router?.showAlert(message: error.localizedDescription)
        }
    }
}
// MARK: - KeyboardPresentable
extension RegisterPresenter: KeyboardPresentable {
    func changeOriginYPointOfView(with yValue: Float, hideBackButton: Bool, animated: Bool) {
        view?.hideNavigationItemBackButtonItem(hideBackButton, animated: animated)
        view?.setOriginYPointOfTheView(with: yValue)
    }
    
    func moveBackToDefaultYPoint(hideBackButton: Bool, animated: Bool) {
        view?.setOriginYPointOfTheView(with: .zero)
        view?.hideNavigationItemBackButtonItem(hideBackButton, animated: animated)
    }
}
