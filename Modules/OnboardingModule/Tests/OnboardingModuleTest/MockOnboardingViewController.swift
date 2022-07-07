//
//  MockOnboardingViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 29.05.2022.
//

import Foundation
@testable import OnboardingModule

final class MockOnboardingViewController: OnboardingPresenterOutputInterface {

    var invokedConfigureOnboardingCollectionView = false
    var invokedConfigureOnboardingCollectionViewCount = 0

    func configureOnboardingCollectionView() {
        invokedConfigureOnboardingCollectionView = true
        invokedConfigureOnboardingCollectionViewCount += 1
    }

    var invokedConfigurePageControl = false
    var invokedConfigurePageControlCount = 0

    func configurePageControl() {
        invokedConfigurePageControl = true
        invokedConfigurePageControlCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedScrollToNextItem = false
    var invokedScrollToNextItemCount = 0
    var invokedScrollToNextItemParameters: (indexPath: IndexPath, Void)?
    var invokedScrollToNextItemParametersList = [(indexPath: IndexPath, Void)]()

    func scrollToNextItem(at indexPath: IndexPath) {
        invokedScrollToNextItem = true
        invokedScrollToNextItemCount += 1
        invokedScrollToNextItemParameters = (indexPath, ())
        invokedScrollToNextItemParametersList.append((indexPath, ()))
    }
}
