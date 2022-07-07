//
//  MockHomeDetailViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 14.06.2022.
//

import Foundation
@testable import HomeDetailModule

final class MockHomeDetailViewController: HomeDetailPresenterOutputInterface {

    var invokedConfigureStepperView = false
    var invokedConfigureStepperViewCount = 0

    func configureStepperView() {
        invokedConfigureStepperView = true
        invokedConfigureStepperViewCount += 1
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

    var invokedConfigureDescriptionLabel = false
    var invokedConfigureDescriptionLabelCount = 0
    var invokedConfigureDescriptionLabelParameters: (text: String, Void)?
    var invokedConfigureDescriptionLabelParametersList = [(text: String, Void)]()

    func configureDescriptionLabel(_ text: String) {
        invokedConfigureDescriptionLabel = true
        invokedConfigureDescriptionLabelCount += 1
        invokedConfigureDescriptionLabelParameters = (text, ())
        invokedConfigureDescriptionLabelParametersList.append((text, ()))
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

    var invokedSetBackgroundColor = false
    var invokedSetBackgroundColorCount = 0

    func setBackgroundColor() {
        invokedSetBackgroundColor = true
        invokedSetBackgroundColorCount += 1
    }

    var invokedDidPriceChanged = false
    var invokedDidPriceChangedCount = 0
    var invokedDidPriceChangedParameters: (price: String, Void)?
    var invokedDidPriceChangedParametersList = [(price: String, Void)]()

    func didPriceChanged(price: String) {
        invokedDidPriceChanged = true
        invokedDidPriceChangedCount += 1
        invokedDidPriceChangedParameters = (price, ())
        invokedDidPriceChangedParametersList.append((price, ()))
    }
}
