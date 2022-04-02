//
//  RegisterPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import UIKit

class RegisterPresenter: NSObject, ViewToPresenterRegisterProtocol {

    var view: PresenterToViewRegisterProtocol?
    
    var interactor: PresenterToInteractorRegisterProtocol?
    
    var router: PresenterToRouterRegisterProtocol?
    
    var profileImage: UIImage?
    
    // MARK: - Method
    
    func didImageSelected(_ info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        view?.makeCircularImage()
        profileImage = selectedImage
        view?.setProfileImage(profileImage!)
        router?.dismissPickerController()
    }
    
    func showPicker() {
        router?.showPickerController()
    }
    
    func popToLogin() {
        router?.popNavToLogin()
    }
    
    func handleRegisterInput(email: String?, password: String?, username: String?) {
        guard let email = email,
              let password = password,
              let username = username,
              !email.isEmpty,
              !password.isEmpty,
              !username.isEmpty,
              profileImage != nil
        else {
            router?.showAlert(title: "Field is empty", message: "One of the field is empty")
            return
        }
        view?.configureAnimation(named: .userLoading, mode: .loop, speed: 2, completion: nil)
        interactor?.registerUser(with: AuthCredentials(email: email,
                                                       password: password,
                                                       username: username,
                                                       profileImage: profileImage!))
    }
}

// MARK: - Interactor To Presenter

extension RegisterPresenter: InteractorToPresenterRegisterProtocol {
    func didErrorOccuredInRegistration(error: Error) {
        view?.removeAnimation()
        router?.showAlert(title: "Error", message: error.localizedDescription)
    }
    func didRegistrationComplete() {
        view?.configureAnimation(named: .registrationSuccess,
                                 mode: .playOnce,
                                 speed: 1.5,
                                 completion: { _ in
            self.view?.removeAnimation()
            self.router?.popNavToLogin()
        })
        
        
    }
}



