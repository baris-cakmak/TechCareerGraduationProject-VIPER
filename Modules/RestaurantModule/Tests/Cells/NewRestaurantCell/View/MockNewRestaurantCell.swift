//
//  MockNewRestaurantCell.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 9.06.2022.
//

import UIKit
@testable import RestaurantModule
@testable import CommonKit

final class MockNewRestaurantCell: NewRestaurantCellInterface {

    var invokedConfigureCellAppeareance = false
    var invokedConfigureCellAppeareanceCount = 0

    func configureCellAppeareance() {
        invokedConfigureCellAppeareance = true
        invokedConfigureCellAppeareanceCount += 1
    }

    var invokedConfigureRestaurantNameLabel = false
    var invokedConfigureRestaurantNameLabelCount = 0
    var invokedConfigureRestaurantNameLabelParameters: (text: String, Void)?
    var invokedConfigureRestaurantNameLabelParametersList = [(text: String, Void)]()

    func configureRestaurantNameLabel(_ text: String) {
        invokedConfigureRestaurantNameLabel = true
        invokedConfigureRestaurantNameLabelCount += 1
        invokedConfigureRestaurantNameLabelParameters = (text, ())
        invokedConfigureRestaurantNameLabelParametersList.append((text, ()))
    }

    var invokedConfigureCategoryLabel = false
    var invokedConfigureCategoryLabelCount = 0
    var invokedConfigureCategoryLabelParameters: (text: String, Void)?
    var invokedConfigureCategoryLabelParametersList = [(text: String, Void)]()

    func configureCategoryLabel(_ text: String) {
        invokedConfigureCategoryLabel = true
        invokedConfigureCategoryLabelCount += 1
        invokedConfigureCategoryLabelParameters = (text, ())
        invokedConfigureCategoryLabelParametersList.append((text, ()))
    }

    var invokedConfigurePointLabel = false
    var invokedConfigurePointLabelCount = 0
    var invokedConfigurePointLabelParameters: (text: String, Void)?
    var invokedConfigurePointLabelParametersList = [(text: String, Void)]()

    func configurePointLabel(_ text: String) {
        invokedConfigurePointLabel = true
        invokedConfigurePointLabelCount += 1
        invokedConfigurePointLabelParameters = (text, ())
        invokedConfigurePointLabelParametersList.append((text, ()))
    }

    var invokedConfigureRestaurantImageView = false
    var invokedConfigureRestaurantImageViewCount = 0
    var invokedConfigureRestaurantImageViewParameters: (imageUrl: URL, Void)?
    var invokedConfigureRestaurantImageViewParametersList = [(imageUrl: URL, Void)]()

    func configureRestaurantImageView(_ imageUrl: URL) {
        invokedConfigureRestaurantImageView = true
        invokedConfigureRestaurantImageViewCount += 1
        invokedConfigureRestaurantImageViewParameters = (imageUrl, ())
        invokedConfigureRestaurantImageViewParametersList.append((imageUrl, ()))
    }

    var invokedConfigureRestaurantPointBackgroundColor = false
    var invokedConfigureRestaurantPointBackgroundColorCount = 0
    var invokedConfigureRestaurantPointBackgroundColorParameters: (color: Colors, Void)?
    var invokedConfigureRestaurantPointBackgroundColorParametersList = [(color: Colors, Void)]()

    func configureRestaurantPointBackgroundColor(_ color: Colors) {
        invokedConfigureRestaurantPointBackgroundColor = true
        invokedConfigureRestaurantPointBackgroundColorCount += 1
        invokedConfigureRestaurantPointBackgroundColorParameters = (color, ())
        invokedConfigureRestaurantPointBackgroundColorParametersList.append((color, ()))
    }
}
