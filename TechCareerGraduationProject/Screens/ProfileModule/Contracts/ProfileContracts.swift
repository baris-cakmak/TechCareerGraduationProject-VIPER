//
//  ProfileContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit

protocol ViewToPresenterProfileProtocol {
    var view: PresenterToViewProfileProtocol? { get set }
    var interactor: PresenterToInteractorProfileProtocol? { get set }
    var router: PresenterToRouterProfileProtocol? { get set }
    
    func viewDidLoad()
    func didTapToLogout()
}
protocol PresenterToInteractorProfileProtocol {
    var presenter: InteractorToPresenterProfileProtocol? { get set }
    
    func fetchUser()
    func logoutTheUser()
    
}
protocol PresenterToRouterProfileProtocol {
    static func createModule() -> UINavigationController
    func showAlert(message: String)
    func changeWindowAsLogin()
}
protocol PresenterToViewProfileProtocol: AnyObject {
    func configureAnimation()
    func removeAnimation()
    func updateView(with viewModel: ProfileViewModel)
}

protocol InteractorToPresenterProfileProtocol: AnyObject {
    func didfetchUser(_ user: User)
    func didErrorOccured(_ error: Error)
    func didUserLogout()
}
