//
//  MockOnboardingCellDelegate.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 27.05.2022.
//

@testable import OnboardingModule
import UIKit

final class MockOnboardingCellDelegate: OnboardingCollectionViewCellDelegate {
    var didUserTapped = false
    var userTappedToNextButtonCount: Int = 0
    func didTapNextButton(_ cell: OnboardingCellInterface) {
        didUserTapped = true
        userTappedToNextButtonCount += 1
    }
}
