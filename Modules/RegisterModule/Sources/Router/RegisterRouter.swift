//
//  RegisterRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit
import CommonKit
import RegisterModuleInterface
import DependencyManagerKit
import SignUpValidatorKit

protocol RegisterRouterInterface: AlertPresentable {
    func showPickerController()
    func dismissPickerController()
    func popNavToLogin()
}

public final class RegisterRouter: RegisterModuleInterface {
    weak public private(set) var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func createModule(using navigationController: UINavigationController) -> UIViewController {
        @Dependency var signUpValidatorInterface: SignUpValidatorInterface
        let view = RegisterViewController.instantiate(with: .register, bundle: .module)
        let interactor = RegisterInteractor()
        let router = RegisterRouter(navigationController: navigationController)
        let presenter = RegisterPresenter(view: view, interactor: interactor, router: router, signUpValidator: signUpValidatorInterface)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Method
extension RegisterRouter: RegisterRouterInterface {
    func showPickerController() {
        let picker = UIImagePickerController()
        picker.delegate = navigationController?.visibleViewController as? RegisterViewController
        picker.allowsEditing = true
        DispatchQueue.main.async {
            self.navigationController?.present(picker, animated: true)
        }
    }
    
    func dismissPickerController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func popNavToLogin() {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - Alert Presentable
extension RegisterRouter: AlertPresentable {
}
