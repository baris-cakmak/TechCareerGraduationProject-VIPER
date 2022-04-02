//
//  RegisterContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit
import Lottie

protocol ViewToPresenterRegisterProtocol {
    var view: PresenterToViewRegisterProtocol? { get set }
    var interactor: PresenterToInteractorRegisterProtocol? { get set }
    var router: PresenterToRouterRegisterProtocol?{ get set }
    
    func didImageSelected(_ info: [UIImagePickerController.InfoKey : Any])
    func showPicker()
    func popToLogin()
    func handleRegisterInput(email: String?, password: String?, username: String?)
}

protocol PresenterToInteractorRegisterProtocol {
    var presenter: InteractorToPresenterRegisterProtocol? { get set }
    func registerUser(with credentials: AuthCredentials)
}

protocol PresenterToRouterRegisterProtocol {
    static func createModule(using navigationController: UINavigationController) -> UIViewController
    func showPickerController()
    func dismissPickerController()
    func popNavToLogin()
    func showAlert(title: String, message: String)
}

protocol InteractorToPresenterRegisterProtocol: AnyObject {
    func didErrorOccuredInRegistration(error: Error)
    func didRegistrationComplete()
}

protocol PresenterToViewRegisterProtocol: AnyObject {
    func makeCircularImage()
    func setProfileImage(_ image: UIImage)
    func configureAnimation(named: Animations, mode: LottieLoopMode?, speed: CGFloat?, completion: LottieCompletionBlock?)
    func removeAnimation()
    
}
