//
//  MockCartCellView.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import UIKit
@testable import TechCareerGraduationProject
@testable import CartModule

final class MockCartCellView: UICollectionViewCell, CartCollectionViewCellInterface {
    
    var invokedConfigureCellAppearance = false
    var invokedConfigureCellAppearanceCount = 0

    func configureCellAppearance() {
        invokedConfigureCellAppearance = true
        invokedConfigureCellAppearanceCount += 1
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

    var invokedConfigureStepperView = false
    var invokedConfigureStepperViewCount = 0
    var invokedConfigureStepperViewParameters: (currentValue: Double, leftButtonText: String)?
    var invokedConfigureStepperViewParametersList = [(currentValue: Double, leftButtonText: String)]()

    func configureStepperView(currentValue: Double, leftButtonText: String) {
        invokedConfigureStepperView = true
        invokedConfigureStepperViewCount += 1
        invokedConfigureStepperViewParameters = (currentValue, leftButtonText)
        invokedConfigureStepperViewParametersList.append((currentValue, leftButtonText))
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

    var invokedConfigureMealDescriptionLabel = false
    var invokedConfigureMealDescriptionLabelCount = 0
    var invokedConfigureMealDescriptionLabelParameters: (text: String, Void)?
    var invokedConfigureMealDescriptionLabelParametersList = [(text: String, Void)]()

    func configureMealDescriptionLabel(_ text: String) {
        invokedConfigureMealDescriptionLabel = true
        invokedConfigureMealDescriptionLabelCount += 1
        invokedConfigureMealDescriptionLabelParameters = (text, ())
        invokedConfigureMealDescriptionLabelParametersList.append((text, ()))
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
}
