//
//  MockRestaurantCell.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 8.06.2022.
//

import UIKit
@testable import RestaurantModule
@testable import CommonKit

final class MockRestaurantCell: UICollectionViewCell, RestaurantCellInterface {

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

    var invokedConfigureDeliveryCostLabel = false
    var invokedConfigureDeliveryCostLabelCount = 0
    var invokedConfigureDeliveryCostLabelParameters: (text: String, Void)?
    var invokedConfigureDeliveryCostLabelParametersList = [(text: String, Void)]()

    func configureDeliveryCostLabel(_ text: String) {
        invokedConfigureDeliveryCostLabel = true
        invokedConfigureDeliveryCostLabelCount += 1
        invokedConfigureDeliveryCostLabelParameters = (text, ())
        invokedConfigureDeliveryCostLabelParametersList.append((text, ()))
    }

    var invokedConfigureAdressLabel = false
    var invokedConfigureAdressLabelCount = 0
    var invokedConfigureAdressLabelParameters: (text: String, Void)?
    var invokedConfigureAdressLabelParametersList = [(text: String, Void)]()

    func configureAdressLabel(_ text: String) {
        invokedConfigureAdressLabel = true
        invokedConfigureAdressLabelCount += 1
        invokedConfigureAdressLabelParameters = (text, ())
        invokedConfigureAdressLabelParametersList.append((text, ()))
    }

    var invokedConfigureRestaurantPointLabel = false
    var invokedConfigureRestaurantPointLabelCount = 0
    var invokedConfigureRestaurantPointLabelParameters: (text: String, Void)?
    var invokedConfigureRestaurantPointLabelParametersList = [(text: String, Void)]()

    func configureRestaurantPointLabel(_ text: String) {
        invokedConfigureRestaurantPointLabel = true
        invokedConfigureRestaurantPointLabelCount += 1
        invokedConfigureRestaurantPointLabelParameters = (text, ())
        invokedConfigureRestaurantPointLabelParametersList.append((text, ()))
    }

    var invokedConfigurePointBackgroundView = false
    var invokedConfigurePointBackgroundViewCount = 0
    var invokedConfigurePointBackgroundViewParameters: (color: Colors, Void)?
    var invokedConfigurePointBackgroundViewParametersList = [(color: Colors, Void)]()

    func configurePointBackgroundView(_ color: Colors) {
        invokedConfigurePointBackgroundView = true
        invokedConfigurePointBackgroundViewCount += 1
        invokedConfigurePointBackgroundViewParameters = (color, ())
        invokedConfigurePointBackgroundViewParametersList.append((color, ()))
    }

    var invokedConfigureRestaurantFoodImageView = false
    var invokedConfigureRestaurantFoodImageViewCount = 0
    var invokedConfigureRestaurantFoodImageViewParameters: (url: URL, Void)?
    var invokedConfigureRestaurantFoodImageViewParametersList = [(url: URL, Void)]()

    func configureRestaurantFoodImageView(with url: URL) {
        invokedConfigureRestaurantFoodImageView = true
        invokedConfigureRestaurantFoodImageViewCount += 1
        invokedConfigureRestaurantFoodImageViewParameters = (url, ())
        invokedConfigureRestaurantFoodImageViewParametersList.append((url, ()))
    }
}
