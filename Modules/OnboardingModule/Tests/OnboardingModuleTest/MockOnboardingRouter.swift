//
//  MockOnboardingRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 29.05.2022.
//

import Foundation
@testable import OnboardingModule

final class MockOnboardingRouter: OnboardingRouterInterface {
    var invokedSetRootViewControllerAsLogin = false
    var invokedSetRootViewControllerAsLoginCount = 0

    func setRootViewControllerAsLogin() {
        invokedSetRootViewControllerAsLogin = true
        invokedSetRootViewControllerAsLoginCount += 1
    }
}
