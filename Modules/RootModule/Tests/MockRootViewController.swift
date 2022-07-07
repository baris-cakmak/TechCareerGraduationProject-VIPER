//
//  MockRootViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 18.06.2022.
//

import UIKit
@testable import RootModule

final class MockRootViewController: RootPresenterOutputInterface {

    var invokedConfigureGlobalNavigationAppereance = false
    var invokedConfigureGlobalNavigationAppereanceCount = 0

    func configureGlobalNavigationAppereance() {
        invokedConfigureGlobalNavigationAppereance = true
        invokedConfigureGlobalNavigationAppereanceCount += 1
    }
}
