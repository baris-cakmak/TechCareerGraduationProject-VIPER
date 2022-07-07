//
//  RegisterViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.03.2022.
//

import UIKit
import Lottie
import CommonKit
import LottieAnimationConfigurableKit

typealias RegisterPresenterOutputInterfaces = CustomTextFieldInterfaces & KeyboardNotificationConfigurable & LottieAnimationConfigurable & TapDismissable

protocol RegisterPresenterOutputInterface: RegisterPresenterOutputInterfaces {
    func configureSignInContainer()
    func setupTextFieldDelegates()
    func makeCircularImage()
    func setProfileImage(_ image: UIImage)
    func configureAnimation(named: Animations, mode: LottieLoopMode, speed: CGFloat, backgroundColor: String, completion: LottieCompletionBlock?)
}

final class RegisterViewController: UIViewController {
    // MARK: - UI Properties
        
    @IBOutlet weak private var signInContainer: CustomView!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var emailTextField: CustomTextField!
    @IBOutlet weak private var passwordTextField: CustomTextField!
    @IBOutlet weak private var usernameTextField: CustomTextField!
    @IBOutlet weak private var profilePhotoButton: UIButton!
    @IBOutlet weak private var signInContainerBlurView: CustomBlurView!
    
    private(set) var animationView: AnimationView? = {
        let aV = AnimationView()
        aV.loopMode = .playOnce
        aV.backgroundColor = RegisterConstants.animationBackgroundColor
        return aV
    }()
    
    // MARK: - Properties
    var activeTextField: UITextField?
    var tapGesture: UITapGestureRecognizer?
    // MARK: - Presenter
    var presenter: RegisterPresenterInterface?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}
// MARK: - Constant
extension RegisterViewController {
    private enum RegisterConstants {
        static let animationBackgroundColor: UIColor = .named("blurBackground").withAlphaComponent(0.7)
        static let profilePhotoBorderWidth: CGFloat = 3.0
        static let profilePohotoBorderColor: CGColor = UIColor.white.cgColor
    }
}
         
// MARK: - Action
extension RegisterViewController {
    @IBAction private func didTapAddProfilePhotoButton(_ sender: UIButton) {
        presenter?.showPicker()
    }
    
    @IBAction private func didTapRegisterButton(_ sender: UIButton) {
        presenter?.validateUserInputs(
            email: emailTextField.text,
            password: passwordTextField.text,
            username: usernameTextField.text
        )
    }
    
    @IBAction private func didTapSignInButton(_ sender: UIButton) {
        presenter?.popToLogin()
    }
}

// MARK: - Presenter To View
extension RegisterViewController: RegisterPresenterOutputInterface {
    func configureSignInContainer() {
        signInContainer.cornerRadius = signInContainer.frame.height / 2
        signInContainerBlurView.cornerRadius = signInContainerBlurView.frame.height / 2
    }
    func setupTextFieldDelegates() {
        [emailTextField, passwordTextField, usernameTextField].forEach { textField in
            textField?.customDelegate = self
            textField?.delegate = textField
        }
    }
    
    func configureAnimation(
        named: Animations,
        mode: LottieLoopMode,
        speed: CGFloat,
        backgroundColor: String,
        completion: LottieCompletionBlock?
    ) {
        if let animationView = animationView {
            animationView.animation = Animation.named(named.rawValue)
            animationView.loopMode = mode
            animationView.animationSpeed = speed
            view.addSubview(animationView)
            animationView.frame = view.bounds
            animationView.play(completion: completion)
        }
    }
    
    func makeCircularImage() {
        profilePhotoButton.layer.cornerRadius = profilePhotoButton.frame.width / 2
        profilePhotoButton.layer.borderColor = RegisterConstants.profilePohotoBorderColor
        profilePhotoButton.layer.borderWidth = RegisterConstants.profilePhotoBorderWidth
        profilePhotoButton.contentMode = .scaleAspectFit
    }
    
    func setProfileImage(_ image: UIImage) {
        profilePhotoButton.setImage(image, for: .normal)
    }
}
// MARK: - CustomTextField Delegate
extension RegisterViewController: CustomTextFieldDelegate {
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

// MARK: - UIImagePickerController Delegate

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        presenter?.didImageSelected(info)
    }
}
// MARK: - Lottie Animation Configurable
extension RegisterViewController: LottieAnimationConfigurable {
}
