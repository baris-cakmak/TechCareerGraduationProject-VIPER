//
//  ProfileViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit
import Lottie
import SDWebImage
import LottieAnimationConfigurableKit
import CommonKit

typealias ProfileInterface = NavigationItemUpdatable & LottieAnimationConfigurable

protocol ProfilePresenterOutputInterface: AnyObject, ProfileInterface {
    func configureRightBarButtonItem()
    func configureProfilePhoto()
    func configureAnimation()
    func removeAnimation()
    func updateView(with viewModel: ProfileViewModel)
}

final class ProfileViewController: UIViewController {
    // MARK: - UI Properties
    
    private(set) var animationView: AnimationView? = {
        let aV = AnimationView(animation: Animation.named(ProfileConstants.animationName))
        aV.animationSpeed = ProfileConstants.animationSpeed
        aV.loopMode = .loop
        aV.backgroundColor = ProfileConstants.animationBackgroundColor
        return aV
    }()
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var usernameLabel: UILabel!
    @IBOutlet weak private var profilePhotoButton: UIButton!
    
    // MARK: - Presenter
    
    var presenter: ProfilePresenterInterface?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}
// MARK: - Constant
extension ProfileViewController {
    private enum ProfileConstants {
        static let profilePhotoBorderWidth: CGFloat = 3.0
        static let profilePhotoBorderColor: CGColor = UIColor.label.cgColor
        static let animationName: String = Animations.userLoading.rawValue
        static let animationSpeed: CGFloat = 2.0
        static let animationBackgroundColor: UIColor = .named("blurBackground2").withAlphaComponent(0.8)
        static let barButtonImage: UIImage = .named("logout")
    }
}
// MARK: - Action
extension ProfileViewController {
    @objc
    func didTapLogoutButton() {
        presenter?.didTapToLogout()
    }
}

// MARK: - Presenter To View

extension ProfileViewController: ProfilePresenterOutputInterface {
    func configureProfilePhoto() {
        profilePhotoButton.layer.borderColor = ProfileConstants.profilePhotoBorderColor
        profilePhotoButton.layer.borderWidth = ProfileConstants.profilePhotoBorderWidth
        profilePhotoButton.contentMode = .scaleAspectFit
        profilePhotoButton.clipsToBounds = true
        profilePhotoButton.layer.cornerRadius = profilePhotoButton.frame.size.height / 2
    }
    
    func configureRightBarButtonItem() {
        navigationItem.rightBarButtonItem = .init(
            image: ProfileConstants.barButtonImage,
            style: .done,
            target: self,
            action: #selector(didTapLogoutButton)
        )
    }
    func updateView(with viewModel: ProfileViewModel) {
        emailLabel.text = viewModel.email
        usernameLabel.text = viewModel.username
        profilePhotoButton.sd_imageIndicator = SDWebImageActivityIndicator.large
        profilePhotoButton.sd_setImage(
            with: viewModel.profileImage,
            for: .normal,
            placeholderImage: Constants.Image.placeholderImage
        )
    }
}
