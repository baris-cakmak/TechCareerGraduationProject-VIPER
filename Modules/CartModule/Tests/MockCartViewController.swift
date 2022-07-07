//
//  MockCartViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 16.06.2022.
//

import UIKit
import Lottie
@testable import CartModule

final class MockCartViewController: CartPresenterOutputInterface {

    var invokedAnimationViewGetter = false
    var invokedAnimationViewGetterCount = 0
    var stubbedAnimationView: AnimationView!

    var animationView: AnimationView? {
        invokedAnimationViewGetter = true
        invokedAnimationViewGetterCount += 1
        return stubbedAnimationView
    }

    var invokedConfigureBarButtonItem = false
    var invokedConfigureBarButtonItemCount = 0

    func configureBarButtonItem() {
        invokedConfigureBarButtonItem = true
        invokedConfigureBarButtonItemCount += 1
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

    var invokedReloadItems = false
    var invokedReloadItemsCount = 0
    var invokedReloadItemsParameters: (indexPath: IndexPath, Void)?
    var invokedReloadItemsParametersList = [(indexPath: IndexPath, Void)]()

    func reloadItems(at indexPath: IndexPath) {
        invokedReloadItems = true
        invokedReloadItemsCount += 1
        invokedReloadItemsParameters = (indexPath, ())
        invokedReloadItemsParametersList.append((indexPath, ()))
    }

    var invokedDeleteItems = false
    var invokedDeleteItemsCount = 0
    var invokedDeleteItemsParameters: (indexPath: IndexPath, Void)?
    var invokedDeleteItemsParametersList = [(indexPath: IndexPath, Void)]()

    func deleteItems(at indexPath: IndexPath) {
        invokedDeleteItems = true
        invokedDeleteItemsCount += 1
        invokedDeleteItemsParameters = (indexPath, ())
        invokedDeleteItemsParametersList.append((indexPath, ()))
    }

    var invokedUpdateCheckoutFooterPrice = false
    var invokedUpdateCheckoutFooterPriceCount = 0

    func updateCheckoutFooterPrice() {
        invokedUpdateCheckoutFooterPrice = true
        invokedUpdateCheckoutFooterPriceCount += 1
    }

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

    var invokedRemoveBadgeNumberFromTabBar = false
    var invokedRemoveBadgeNumberFromTabBarCount = 0

    func removeBadgeNumberFromTabBar() {
        invokedRemoveBadgeNumberFromTabBar = true
        invokedRemoveBadgeNumberFromTabBarCount += 1
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
