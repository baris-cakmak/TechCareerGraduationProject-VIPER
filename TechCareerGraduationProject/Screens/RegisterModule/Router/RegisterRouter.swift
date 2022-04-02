//
//  RegisterRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit

class RegisterRouter: PresenterToRouterRegisterProtocol {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController: UINavigationController) -> UIViewController {
        let userManager = UserManager()
        let view = RegisterViewController.instantiate(with: .register)
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor(userManager: userManager)
        let router = RegisterRouter(navigationController: navigationController)
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
        
    }
    
    // MARK: - Method
    
    func showPickerController() {
        let picker = UIImagePickerController()
        // does not work if it is not uiviewcontroller
        picker.delegate = navigationController?.visibleViewController as? RegisterViewController
        picker.allowsEditing = true
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(picker, animated: true)
        }
    }
    
    func dismissPickerController() {
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func popNavToLogin() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.navigationController?.visibleViewController?.present(alertController, animated: true)
        }
    }
}
