//
//  LoginContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit

protocol ViewToPresenterLoginProtocol {
    var view: PresenterToViewLoginProtocol? { get set }
    var interactor: PresenterToInteractorLoginProtocol?{ get set }
    var router: PresenterToRouterLoginProtocol? { get set }
    
    func didUserTappedToLogIn(email: String?, password: String?)
    func didUserTappedToSignUp()
}

protocol PresenterToInteractorLoginProtocol {
    var presenter: InteractorToPresenterLoginProtocol? { get set }
    func logUserIn(email: String, password: String)
}


protocol PresenterToRouterLoginProtocol {
    static func createModule() -> UINavigationController
    func showAlert(title: String, message: String)
    func showSignUpPage()
    func changeWindowAsMainTab()
}

protocol InteractorToPresenterLoginProtocol: AnyObject {
    func didErrorOccuredInLogin(error: Error)
    func didLogInSuccessfully()
}
protocol PresenterToViewLoginProtocol: AnyObject {
    func showLoadingAnimation()
    func removeAnimation()
}


