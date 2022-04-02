//
//  LoginViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.03.2022.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {

    // MARK: - UI Properties

    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    private let animationView: AnimationView = {
        let animation = Animation.named(Animations.userLoading.rawValue)
        let aV = AnimationView(animation: animation)
        aV.loopMode = .loop
        aV.animationSpeed = 2
        aV.backgroundColor = UIColor(named: "blurBackground2")?.withAlphaComponent(0.7)
        return aV
    }()
    
    // MARK: - Presenter
    var presenter: ViewToPresenterLoginProtocol?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Action
    
    @IBAction func didLoginTapped(_ sender: UIButton) {
        
        presenter?.didUserTappedToLogIn(email: emailTextField.text,
                                        password: passwordTextField.text)
    }
    
    @IBAction func didSignUpTapped(_ sender: UIButton) {
        presenter?.didUserTappedToSignUp()
    }
}


// MARK: - Presenter To View

extension LoginViewController: PresenterToViewLoginProtocol {
    func showLoadingAnimation() {
        view.addSubview(animationView)
        animationView.frame = view.bounds
        animationView.play()
    }
    
    func removeAnimation() {
        DispatchQueue.main.async {
            self.animationView.removeFromSuperview()

        }
    }
}
