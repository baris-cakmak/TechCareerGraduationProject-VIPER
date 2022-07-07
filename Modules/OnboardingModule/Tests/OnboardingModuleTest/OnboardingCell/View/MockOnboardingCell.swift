//
//  MockOnboardingCell.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 27.05.2022.
//

import UIKit
import Lottie
@testable import OnboardingModule
@testable import TechCareerGraduationProject

final class MockOnboardingCell: OnboardingCellInterface { var isButtonAppearanceConfigured = false
    func configureNextButtonAppearance() {
        isButtonAppearanceConfigured = true
    }
    
    var isOnboardingAnimationCalled = false
    var animationLoopMode: LottieLoopMode? = nil
    var animationContentMode: UIView.ContentMode? = nil
    var animationName: String?
    func configureAnimationView(loopMode: LottieLoopMode, contentMode: UIView.ContentMode, animationName: String) {
        isOnboardingAnimationCalled = true
        animationLoopMode = loopMode
        animationContentMode = contentMode
        self.animationName = animationName
    }
    
    
    var isCellConfiguredWithViewModel = false
    func configureCell(with viewModel: OnboardingViewModel) {
        isOnboardingAnimationCalled = true
    }
    
    var isConfigureNextButtonAttributesCalled = false
    var titleOfNextButton: String?
    var backgroundColorOfNextButton: UIColor?
    
    func configureNextButtonAttributes(title: String, backgroundColor: String) {
        backgroundColorOfNextButton = UIColor(named: backgroundColor, in: OnboardingModuleResources.bundle, compatibleWith: nil)
        titleOfNextButton = title
        isConfigureNextButtonAttributesCalled = true
    }
    
    var isConfigureDescriptionLabelCalled = false
    var descriptionLabelText: String?
    
    func configureDescriptionLabel(text: String) {
        isConfigureDescriptionLabelCalled = true
        descriptionLabelText = text
    }
}
