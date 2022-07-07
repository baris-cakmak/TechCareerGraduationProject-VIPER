//
//  MockHomeCellView.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import UIKit
@testable import HomeModule

final class MockHomeCellView: HomeCellInterface {

    var invokedConfigureCellAppearance = false
    var invokedConfigureCellAppearanceCount = 0

    func configureCellAppearance() {
        invokedConfigureCellAppearance = true
        invokedConfigureCellAppearanceCount += 1
    }

    var invokedConfigurePriceLabel = false
    var invokedConfigurePriceLabelCount = 0
    var invokedConfigurePriceLabelParameters: (text: String, Void)?
    var invokedConfigurePriceLabelParametersList = [(text: String, Void)]()

    func configurePriceLabel(_ text: String) {
        invokedConfigurePriceLabel = true
        invokedConfigurePriceLabelCount += 1
        invokedConfigurePriceLabelParameters = (text, ())
        invokedConfigurePriceLabelParametersList.append((text, ()))
    }

    var invokedConfigureMealImageView = false
    var invokedConfigureMealImageViewCount = 0
    var invokedConfigureMealImageViewParameters: (url: URL, Void)?
    var invokedConfigureMealImageViewParametersList = [(url: URL, Void)]()

    func configureMealImageView(with url: URL) {
        invokedConfigureMealImageView = true
        invokedConfigureMealImageViewCount += 1
        invokedConfigureMealImageViewParameters = (url, ())
        invokedConfigureMealImageViewParametersList.append((url, ()))
    }

    var invokedConfigureMealNameLabel = false
    var invokedConfigureMealNameLabelCount = 0
    var invokedConfigureMealNameLabelParameters: (text: String, Void)?
    var invokedConfigureMealNameLabelParametersList = [(text: String, Void)]()

    func configureMealNameLabel(_ text: String) {
        invokedConfigureMealNameLabel = true
        invokedConfigureMealNameLabelCount += 1
        invokedConfigureMealNameLabelParameters = (text, ())
        invokedConfigureMealNameLabelParametersList.append((text, ()))
    }
}
