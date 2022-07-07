//
//  MockRootInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 18.06.2022.
//

import Foundation
@testable import RootModule

final class MockRootInteractor: RootInteractorInterface {
    var invokedCheckUserIsLoggedIn = false
    var invokedCheckUserIsLoggedInCount = 0

    func checkUserIsLoggedIn() {
        invokedCheckUserIsLoggedIn = true
        invokedCheckUserIsLoggedInCount += 1
    }

    var invokedCheckOnboardingSeen = false
    var invokedCheckOnboardingSeenCount = 0

    func checkOnboardingSeen() {
        invokedCheckOnboardingSeen = true
        invokedCheckOnboardingSeenCount += 1
    }
}
