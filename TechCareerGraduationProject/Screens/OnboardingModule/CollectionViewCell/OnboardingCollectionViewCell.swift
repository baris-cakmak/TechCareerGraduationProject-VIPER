//
//  OnboardingCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import UIKit
import Lottie

protocol OnboardingCollectionViewCellDelegate: AnyObject {
    func didTapNextButton(_ cell: OnboardingCollectionViewCell)
}


class OnboardingCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Properties
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var onboardingAnimationView: AnimationView!
    @IBOutlet weak var decriptionLabel: UILabel!
    
    // MARK: - Delegate
    
    weak var delegate:OnboardingCollectionViewCellDelegate?
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAnimationView()
        configureNextButtonView()
    }
        
    // MARK: - Helper
    func configureAnimationView() {
        onboardingAnimationView.loopMode = .loop
        onboardingAnimationView.contentMode = .scaleAspectFill
    }
    
    func configureNextButtonView() {
        nextButton.layer.borderWidth = 0.3
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.shadowOpacity = 1
        nextButton.layer.shadowRadius = 5 
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 5.5)
        nextButton.layer.shadowColor = UIColor.black.cgColor
    }
    
    
    func configureCell(with viewModel: OnboardingViewModel) {
        onboardingAnimationView.animation = Animation.named(viewModel.animationName.rawValue)
        decriptionLabel.text = viewModel.descriptionText
        nextButton.backgroundColor = viewModel.buttonBackgroundColor
        nextButton.setTitle(viewModel.buttonText, for: .normal)
        onboardingAnimationView.play()
    }
    
    // MARK: - Action
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        delegate?.didTapNextButton(self)
    }
}
