//
//  MockHomeViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 9.06.2022.
//

import Foundation
import Lottie
@testable import HomeModule
@testable import CommonKit
@testable import LottieAnimationConfigurableKit

final class MockHomeViewController: HomePresenterOutputInterface, LottieAnimationConfigurable, NavigationItemUpdatable {

    var invokedAnimationViewGetter = false
    var invokedAnimationViewGetterCount = 0
    var stubbedAnimationView: AnimationView!

    var animationView: AnimationView? {
        invokedAnimationViewGetter = true
        invokedAnimationViewGetterCount += 1
        return stubbedAnimationView
    }

    var invokedConfigureMealCollectionView = false
    var invokedConfigureMealCollectionViewCount = 0

    func configureMealCollectionView() {
        invokedConfigureMealCollectionView = true
        invokedConfigureMealCollectionViewCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedUpdateBadgeCountOfCartTabBar = false
    var invokedUpdateBadgeCountOfCartTabBarCount = 0
    var invokedUpdateBadgeCountOfCartTabBarParameters: (badgeValue: String?, Void)?
    var invokedUpdateBadgeCountOfCartTabBarParametersList = [(badgeValue: String?, Void)]()

    func updateBadgeCountOfCartTabBar(badgeValue: String?) {
        invokedUpdateBadgeCountOfCartTabBar = true
        invokedUpdateBadgeCountOfCartTabBarCount += 1
        invokedUpdateBadgeCountOfCartTabBarParameters = (badgeValue, ())
        invokedUpdateBadgeCountOfCartTabBarParametersList.append((badgeValue, ()))
    }

    var invokedConfigureAnimation = false
    var invokedConfigureAnimationCount = 0

    func configureAnimation() {
        invokedConfigureAnimation = true
        invokedConfigureAnimationCount += 1
    }

    var invokedRemoveAnimation = false
    var invokedRemoveAnimationCount = 0

    func removeAnimation() {
        invokedRemoveAnimation = true
        invokedRemoveAnimationCount += 1
    }

    var invokedSetNavigationItemTitle = false
    var invokedSetNavigationItemTitleCount = 0
    var invokedSetNavigationItemTitleParameters: (title: String, Void)?
    var invokedSetNavigationItemTitleParametersList = [(title: String, Void)]()

    func setNavigationItemTitle(with title: String) {
        invokedSetNavigationItemTitle = true
        invokedSetNavigationItemTitleCount += 1
        invokedSetNavigationItemTitleParameters = (title, ())
        invokedSetNavigationItemTitleParametersList.append((title, ()))
    }
}
