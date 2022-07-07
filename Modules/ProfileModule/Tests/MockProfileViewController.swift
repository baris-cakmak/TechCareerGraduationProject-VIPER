//
//  MockProfileViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import Foundation
import Lottie
@testable import ProfileModule

final class MockProfileViewController: ProfilePresenterOutputInterface {

    var invokedAnimationViewGetter = false
    var invokedAnimationViewGetterCount = 0
    var stubbedAnimationView: AnimationView!

    var animationView: AnimationView? {
        invokedAnimationViewGetter = true
        invokedAnimationViewGetterCount += 1
        return stubbedAnimationView
    }

    var invokedConfigureRightBarButtonItem = false
    var invokedConfigureRightBarButtonItemCount = 0

    func configureRightBarButtonItem() {
        invokedConfigureRightBarButtonItem = true
        invokedConfigureRightBarButtonItemCount += 1
    }

    var invokedConfigureProfilePhoto = false
    var invokedConfigureProfilePhotoCount = 0

    func configureProfilePhoto() {
        invokedConfigureProfilePhoto = true
        invokedConfigureProfilePhotoCount += 1
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

    var invokedUpdateView = false
    var invokedUpdateViewCount = 0
    var invokedUpdateViewParameters: (viewModel: ProfileViewModel, Void)?
    var invokedUpdateViewParametersList = [(viewModel: ProfileViewModel, Void)]()

    func updateView(with viewModel: ProfileViewModel) {
        invokedUpdateView = true
        invokedUpdateViewCount += 1
        invokedUpdateViewParameters = (viewModel, ())
        invokedUpdateViewParametersList.append((viewModel, ()))
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
