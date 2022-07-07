//
//  MockRootRouter.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 18.06.2022.
//

import Foundation
@testable import RootModule

final class MockRootRouter: RootRouterInterface {

    var invokedChangeWindowAsLoginModule = false
    var invokedChangeWindowAsLoginModuleCount = 0

    func changeWindowAsLoginModule() {
        invokedChangeWindowAsLoginModule = true
        invokedChangeWindowAsLoginModuleCount += 1
    }

    var invokedChangeWindowAsTabBarModule = false
    var invokedChangeWindowAsTabBarModuleCount = 0

    func changeWindowAsTabBarModule() {
        invokedChangeWindowAsTabBarModule = true
        invokedChangeWindowAsTabBarModuleCount += 1
    }

    var invokedChangeWindowAsOnboarding = false
    var invokedChangeWindowAsOnboardingCount = 0

    func changeWindowAsOnboarding() {
        invokedChangeWindowAsOnboarding = true
        invokedChangeWindowAsOnboardingCount += 1
    }
}
