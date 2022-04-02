//
//  ProfileViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit
import Lottie
import SDWebImage

class ProfileViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let animationView: AnimationView = {
        let aV = AnimationView(animation: Animation.named(Animations.userLoading.rawValue))
        aV.animationSpeed = 2
        aV.loopMode = .loop
        aV.backgroundColor = UIColor(named: "blurBackground2")?.withAlphaComponent(0.8)
        return aV
    }()
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePhotoButton: UIButton!
    
    // MARK: - Presenter
    
    var presenter: ViewToPresenterProfileProtocol?
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfilePhoto()
        configureNavigationItem()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Helper
    
    func configureProfilePhoto() {
        // fix needed
        profilePhotoButton.layer.borderColor = UIColor.label.cgColor
        profilePhotoButton.layer.borderWidth = 3
        profilePhotoButton.contentMode = .scaleAspectFit
        profilePhotoButton.clipsToBounds = true
        profilePhotoButton.layer.cornerRadius = profilePhotoButton.frame.size.width / 2 - 15
    }
    
    func configureNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(didTapLogoutButton))
    }
    
    
    // MARK: - Action
    @objc
    func didTapLogoutButton() {
        presenter?.didTapToLogout()
    }
}

// MARK: - Presenter To View

extension ProfileViewController: PresenterToViewProfileProtocol {
    
    func configureAnimation() {
        view.addSubview(animationView)
        animationView.frame = view.bounds
        animationView.play()
    }
    func removeAnimation() {
        DispatchQueue.main.async {
            self.animationView.removeFromSuperview()
        }
    }
    func updateView(with viewModel: ProfileViewModel) {
        emailLabel.text = viewModel.email
        usernameLabel.text = viewModel.username
        profilePhotoButton.sd_imageIndicator = SDWebImageActivityIndicator.large
        profilePhotoButton.sd_setImage(with: viewModel.profileImage, for: .normal, placeholderImage: UIImage(named: "placeholderImage")!)
        print("debug: viewmodel", viewModel.username, viewModel.email, viewModel.profileImage.absoluteString)
    }
}
