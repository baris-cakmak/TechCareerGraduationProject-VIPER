//
//  MockOffersCell.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 26.05.2022.
//

import UIKit
@testable import RestaurantModule

final class MockOffersCell: OffersCollectionViewCellInterface {

    var invokedConfigureCellAppearance = false
    var invokedConfigureCellAppearanceCount = 0

    func configureCellAppearance() {
        invokedConfigureCellAppearance = true
        invokedConfigureCellAppearanceCount += 1
    }

    var invokedConfigureOfferTitleLabel = false
    var invokedConfigureOfferTitleLabelCount = 0
    var invokedConfigureOfferTitleLabelParameters: (text: String, Void)?
    var invokedConfigureOfferTitleLabelParametersList = [(text: String, Void)]()

    func configureOfferTitleLabel(_ text: String) {
        invokedConfigureOfferTitleLabel = true
        invokedConfigureOfferTitleLabelCount += 1
        invokedConfigureOfferTitleLabelParameters = (text, ())
        invokedConfigureOfferTitleLabelParametersList.append((text, ()))
    }

    var invokedConfigureOfferImageView = false
    var invokedConfigureOfferImageViewCount = 0
    var invokedConfigureOfferImageViewParameters: (url: URL, Void)?
    var invokedConfigureOfferImageViewParametersList = [(url: URL, Void)]()

    func configureOfferImageView(with url: URL) {
        invokedConfigureOfferImageView = true
        invokedConfigureOfferImageViewCount += 1
        invokedConfigureOfferImageViewParameters = (url, ())
        invokedConfigureOfferImageViewParametersList.append((url, ()))
    }
}
