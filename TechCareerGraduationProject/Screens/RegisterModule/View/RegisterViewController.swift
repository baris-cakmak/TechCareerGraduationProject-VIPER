//
//  RegisterViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.03.2022.
//

import UIKit
import Lottie
import Moya

class RegisterViewController: UIViewController {
    
    // MARK: - UI Properties
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var usernameTextField: CustomTextField!
    @IBOutlet weak var profilePhotoButton: UIButton!
    
    private let animationView: AnimationView = {
        let aV = AnimationView()
        aV.loopMode = .playOnce
        return aV
    }()
    // MARK: - Presenter
    
    var presenter: ViewToPresenterRegisterProtocol?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    @IBAction func didTapAddProfilePhotoButton(_ sender: UIButton) {
        // I have different approach to presenting and delegating in router. "Code smells"
        presenter?.showPicker()
        
    }
    
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        presenter?.handleRegisterInput(email: emailTextField.text,
                                       password: passwordTextField.text,
                                       username: usernameTextField.text)
    }
    
    @IBAction func didTapSignInButton(_ sender: UIButton) {
        presenter?.popToLogin()
    }
}


// MARK: - Presenter To View
extension RegisterViewController: PresenterToViewRegisterProtocol {
    
    
    func configureAnimation(named: Animations, mode: LottieLoopMode?, speed: CGFloat?, completion: LottieCompletionBlock?) {
        animationView.animation = Animation.named(named.rawValue)
        animationView.loopMode = mode ?? .loop
        animationView.animationSpeed = speed ?? 1
        animationView.backgroundColor = UIColor(named: "blurBackground2")?.withAlphaComponent(0.7)
        view.addSubview(animationView)
        animationView.frame = view.bounds
        animationView.play(completion: completion)
    }
    
    func removeAnimation() {
        DispatchQueue.main.async {
            self.animationView.removeFromSuperview()
        }
    }
    


    
    func makeCircularImage() {
        profilePhotoButton.layer.cornerRadius = profilePhotoButton.frame.width / 2
        profilePhotoButton.layer.borderColor = UIColor.white.cgColor
        profilePhotoButton.layer.borderWidth = 3
        profilePhotoButton.contentMode = .scaleAspectFit
        
    }
    
    func setProfileImage(_ image: UIImage) {
        profilePhotoButton.setImage(image, for: .normal)
    }

}

// MARK: - UIImagePickerController Delegate

extension RegisterViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        presenter?.didImageSelected(info)
    }
}
