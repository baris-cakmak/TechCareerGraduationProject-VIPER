//
//  MockRestaurantViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 8.06.2022.
//

import Foundation
import Lottie
@testable import RestaurantModule

final class MockRestaurantViewController: RestaurantPresenterOutputInterface {

    var invokedAnimationViewGetter = false
    var invokedAnimationViewGetterCount = 0
    var stubbedAnimationView: AnimationView!

    var animationView: AnimationView? {
        invokedAnimationViewGetter = true
        invokedAnimationViewGetterCount += 1
        return stubbedAnimationView
    }

    var invokedConfigureRestaurantCollectionView = false
    var invokedConfigureRestaurantCollectionViewCount = 0

    func configureRestaurantCollectionView() {
        invokedConfigureRestaurantCollectionView = true
        invokedConfigureRestaurantCollectionViewCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
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
