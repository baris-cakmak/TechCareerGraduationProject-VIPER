//
//  OnboardingCellPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 20.05.2022.
//

import Foundation

protocol OnboardingCellPresenterInterface {
    func didTapNextButton(_ cell: OnboardingCellInterface)
    func loadCell()
}

protocol OnboardingCollectionViewCellDelegate: AnyObject {
    func didTapNextButton(_ cell: OnboardingCellInterface)
}

final class OnboardingCellPresenter: OnboardingCellPresenterInterface {
    weak private var view: OnboardingCellInterface?
    weak private var delegate: OnboardingCollectionViewCellDelegate?
    private(set) var onboardingViewModel: OnboardingViewModel
    
    init(
        view: OnboardingCellInterface,
        onboardingViewModel: OnboardingViewModel,
        delegate: OnboardingCollectionViewCellDelegate
    ) {
        self.view = view
        self.onboardingViewModel = onboardingViewModel
        self.delegate = delegate
    }
}

// MARK: - Helper
extension OnboardingCellPresenter {
    func configureDescriptionLabel() {
        if let descriptionText = onboardingViewModel.descriptionText {
            view?.configureDescriptionLabel(text: descriptionText)
        }
    }
    
    func configureAnimation() {
        if let animationName = onboardingViewModel.animationName?.rawValue {
            view?.configureAnimationView(
                loopMode: .loop,
                contentMode: .scaleAspectFill,
                animationName: animationName
            )
        }
    }
    
    func configureNextButton() {
        view?.configureNextButtonAppearance()
        if
            let buttonText = onboardingViewModel.buttonText,
            let buttonBackgroundColor = onboardingViewModel.buttonBackgroundColor {
            view?.configureNextButtonAttributes(
                title: buttonText,
                backgroundColor: buttonBackgroundColor
            )
        }
    }
}

// MARK: - Method
extension OnboardingCellPresenter {
    func loadCell() {
        configureNextButton()
        configureAnimation()
        configureDescriptionLabel()
    }
    func didTapNextButton(_ cell: OnboardingCellInterface) {
        delegate?.didTapNextButton(cell)
    }
}
