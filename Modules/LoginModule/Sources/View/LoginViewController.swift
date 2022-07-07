//
//  LoginViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.03.2022.
//

import UIKit
import LottieAnimationConfigurableKit
import Lottie
import CommonKit

typealias LoginPresenterOutputInterfaces = LottieAnimationConfigurable & CustomTextFieldInterfaces & KeyboardNotificationConfigurable & TapDismissable

protocol LoginPresenterOutputInterface: LoginPresenterOutputInterfaces {
    func setupTextFieldDelegates()
}

final class LoginViewController: UIViewController {
    // MARK: - UI Properties
    @IBOutlet weak private var emailTextField: CustomTextField!
    @IBOutlet weak private var passwordTextField: CustomTextField!
    private(set) var animationView: AnimationView? = {
        let animation = Animation.named(LoginConstants.animationName)
        let aV = AnimationView(animation: animation)
        aV.loopMode = .loop
        aV.animationSpeed = LoginConstants.animationSpeed
        aV.backgroundColor = LoginConstants.animationBackgroundColor
        return aV
    }()
    // MARK: - Properties
    var tapGesture: UITapGestureRecognizer?
    var activeTextField: UITextField?
    // MARK: - Presenter
    var presenter: LoginPresenterInterface?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}
// MARK: - Constant
extension LoginViewController {
    private enum LoginConstants {
        static let animationSpeed: CGFloat = 2.0
        static let animationBackgroundColor: UIColor = .named("blurBackground2").withAlphaComponent(0.7)
        static let animationName: String = Animations.userLoading.rawValue
    }
}

// MARK: - Action
extension LoginViewController {
    @IBAction private func didLoginTapped(_ sender: UIButton) {
        presenter?.didUserTappedToLogIn(
            email: emailTextField.text,
            password: passwordTextField.text
        )
    }

    @IBAction private func didSignUpTapped(_ sender: UIButton) {
        presenter?.didUserTappedToSignUp()
    }
}

// MARK: - CustomTextField Delegate
extension LoginViewController: CustomTextFieldDelegate {
    func didKeyboardResultsCalculated(
        _ textField: UITextField,
        keyboardHeight: Float,
        bottomOfTheTextField: Float,
        viewHeight: Float
    ) {
        presenter?.handleTappedTextFieldToDecideOnViewFrameChange(
            keyboardHeight: keyboardHeight,
            bottomOfTheTextField: bottomOfTheTextField,
            viewHeight: viewHeight
        )
    }
}

extension LoginViewController: TapDismissable {
}

// MARK: - Presenter To View
extension LoginViewController: LoginPresenterOutputInterface {
    func setupTextFieldDelegates() {
        [emailTextField, passwordTextField].forEach { customTextField in
            customTextField?.customDelegate = self
            customTextField?.delegate = customTextField
        }
    }
}
// MARK: - Lottie Animation Configurable
extension LoginViewController: LottieAnimationConfigurable {
}
