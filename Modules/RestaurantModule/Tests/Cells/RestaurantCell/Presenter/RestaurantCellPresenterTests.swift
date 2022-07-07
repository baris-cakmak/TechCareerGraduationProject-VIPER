//
//  RestaurantCellPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 9.06.2022.
//

import XCTest
@testable import RestaurantModule
@testable import CommonKit

final class RestaurantCellPresenterTests: XCTestCase {
    var view: MockRestaurantCell!
    var sut: RestaurantCellPresenter!
    
    private func createRestaurantCellPresenter(restaurant: RestaurantViewModel) {
        sut = .init(view: view, restaurantViewModel: restaurant)
    }
    override func setUp() {
        view = MockRestaurantCell()
        sut = .init(view: view, restaurantViewModel: .init())
    }
    override func tearDown() {
        view = nil
        sut = nil
    }
    func test_loadCell_WithValidViewModelParameters_InvokeRequiredParameters() {
        createRestaurantCellPresenter(restaurant: .init(restaurantPointBackgroundColor: .green, restaurantImageUrl: .string("imageUrlString"), restaurantAdress: "adress", restaurantPoint: "1", restaurantName: "name", restaurantDeliveryCost: "1", restaurantMinimumCost: "1"))
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantFoodImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePointBackgroundViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureAdressLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantPointLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureDeliveryCostLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantNameLabelCount, .zero)
        
        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantFoodImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigurePointBackgroundViewCount, 1)
        XCTAssertEqual(view.invokedConfigureAdressLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantPointLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureDeliveryCostLabelCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantNameLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantFoodImageViewParameters?.url, .string("imageUrlString"))
        XCTAssertEqual(view.invokedConfigurePointBackgroundViewParameters?.color, .green)
        XCTAssertEqual(view.invokedConfigureAdressLabelParameters?.text, "adress")
        XCTAssertEqual(view.invokedConfigureRestaurantPointLabelParameters?.text, "1")
        XCTAssertEqual(view.invokedConfigureDeliveryCostLabelParameters?.text, "1")
        XCTAssertEqual(view.invokedConfigurePriceLabelParameters?.text, "1")
        XCTAssertEqual(view.invokedConfigureRestaurantNameLabelParameters?.text, "name")
    }
    func test_loadCell_WithNotValidViewModelParameters_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantFoodImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePointBackgroundViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureAdressLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantPointLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureDeliveryCostLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantNameLabelCount, .zero)
        
        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantFoodImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigurePointBackgroundViewCount, 1)
        XCTAssertEqual(view.invokedConfigureAdressLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantPointLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureDeliveryCostLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantFoodImageViewParameters?.url, .string(Constants.MealApi.somethingWentWrongUrl))
        XCTAssertEqual(view.invokedConfigurePointBackgroundViewParameters?.color, .brokenWhite)
    }
}
