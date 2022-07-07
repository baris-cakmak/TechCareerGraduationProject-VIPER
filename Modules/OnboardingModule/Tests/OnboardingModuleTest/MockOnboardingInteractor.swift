//
//  MockOnboardingInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 29.05.2022.
//

import Foundation
@testable import OnboardingModule

final class MockOnboardingInteractor: OnboardingInteractorInterface {

    var invokedSetOnboardingSeen = false
    var invokedSetOnboardingSeenCount = 0

    func setOnboardingSeen() {
        invokedSetOnboardingSeen = true
        invokedSetOnboardingSeenCount += 1
    }
}
