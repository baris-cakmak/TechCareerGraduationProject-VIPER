//
//  MockMainTabBarViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 19.06.2022.
//

import Foundation
@testable import MainTabBarModule

final class MockMainTabBarViewController: MainTabBarPresenterOutputInterface {

    var invokedUpdateBadgeValueOfCartTabBar = false
    var invokedUpdateBadgeValueOfCartTabBarCount = 0
    var invokedUpdateBadgeValueOfCartTabBarParameters: (value: String?, Void)?
    var invokedUpdateBadgeValueOfCartTabBarParametersList = [(value: String?, Void)]()

    func updateBadgeValueOfCartTabBar(_ value: String?) {
        invokedUpdateBadgeValueOfCartTabBar = true
        invokedUpdateBadgeValueOfCartTabBarCount += 1
        invokedUpdateBadgeValueOfCartTabBarParameters = (value, ())
        invokedUpdateBadgeValueOfCartTabBarParametersList.append((value, ()))
    }

    var invokedConfigureTabBarAppeareance = false
    var invokedConfigureTabBarAppeareanceCount = 0

    func configureTabBarAppeareance() {
        invokedConfigureTabBarAppeareance = true
        invokedConfigureTabBarAppeareanceCount += 1
    }

    var invokedConfigureViewControllers = false
    var invokedConfigureViewControllersCount = 0

    func configureViewControllers() {
        invokedConfigureViewControllers = true
        invokedConfigureViewControllersCount += 1
    }
}
