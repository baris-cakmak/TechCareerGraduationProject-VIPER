//
//  OnboardingCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import UIKit
import Lottie

protocol OnboardingCellInterface: AnyObject {
    func configureNextButtonAppearance()
    func configureNextButtonAttributes(title: String, backgroundColor: String)
    func configureAnimationView(loopMode: LottieLoopMode, contentMode: UIView.ContentMode, animationName: String)
    func configureDescriptionLabel(text: String)
}

final class OnboardingCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Properties
    
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var onboardingAnimationView: AnimationView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    // MARK: - Presenter
    var presenter: OnboardingCellPresenterInterface? {
        didSet {
            presenter?.loadCell()
        }
    }
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Constant
extension OnboardingCollectionViewCell {
    private enum OnboardingConstants {
        static let nextButtonBorderWidth: CGFloat = 0.3
        static let nextButtonBorderColor: CGColor = UIColor.black.cgColor
        static let nextButtonShadowOpacity: Float = 1
        static let nextButtonShadowRadius: CGFloat = 5
        static let nextButtonShadowOffset: CGSize = .init(width: 0, height: 5.5)
        static let nextButtonShadowColor: CGColor = UIColor.black.cgColor
    }
}

// MARK: - Action
extension OnboardingCollectionViewCell {
    @IBAction private func didTapNextButton(_ sender: UIButton) {
        presenter?.didTapNextButton(self)
    }
}
// MARK: - OnboardingCellInterface
extension OnboardingCollectionViewCell: OnboardingCellInterface {
    func configureDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
    
    func configureNextButtonAttributes(title: String, backgroundColor: String) {
        nextButton.backgroundColor = UIColor.named(backgroundColor)
        nextButton.setTitle(title, for: .normal)
    }
    
    func configureNextButtonAppearance() {
        nextButton.layer.borderWidth = OnboardingConstants.nextButtonBorderWidth
        nextButton.layer.borderColor = OnboardingConstants.nextButtonBorderColor
        nextButton.layer.shadowOpacity = OnboardingConstants.nextButtonShadowOpacity
        nextButton.layer.shadowRadius = OnboardingConstants.nextButtonShadowRadius
        nextButton.layer.shadowOffset = OnboardingConstants.nextButtonShadowOffset
        nextButton.layer.shadowColor = OnboardingConstants.nextButtonShadowColor
    }
    
    func configureAnimationView(loopMode: LottieLoopMode, contentMode: UIView.ContentMode, animationName: String) {
        onboardingAnimationView.animation = Animation.named(animationName)
        onboardingAnimationView.loopMode = loopMode
        onboardingAnimationView.contentMode = contentMode
        onboardingAnimationView.play()
    }
}
