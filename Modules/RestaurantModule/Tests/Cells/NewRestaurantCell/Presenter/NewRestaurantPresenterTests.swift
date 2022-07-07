//
//  NewRestaurantPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 9.06.2022.
//

import XCTest
@testable import RestaurantModule
@testable import CommonKit

final class NewRestaurantPresenterTests: XCTestCase {
    var sut: NewRestaurantCellPresenter!
    var view: MockNewRestaurantCell!
    
    private func createNewRestaurantCellPresenter(with newRestaurantViewModel: NewRestaurantViewModel) {
        sut = .init(view: view, newRestaurantViewModel: newRestaurantViewModel)
    }
    override  func setUp() {
        let newRestaurantViewModel: NewRestaurantViewModel = .init(restaurantPointBackgroundColor: .green, restaurantImageUrl: .init(string: "url"), categoryTitle: "kebap", restaurantPoint: "9.5", restaurantName: "name", restaurantStatus: .excellent)
        view = MockNewRestaurantCell()
        sut = .init(view: view, newRestaurantViewModel: newRestaurantViewModel)
    }
    override func tearDown() {
        view = nil
        sut = nil
    }
    
    func test_loadCell_WithNotNilViewModelParameters_InvokeRequiredParameters() {
        XCTAssertEqual(view.invokedConfigureCategoryLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantPointBackgroundColorCount, .zero)
        XCTAssertEqual(view.invokedConfigurePointLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, .zero)
        
        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigureCategoryLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigurePointLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantPointBackgroundColorCount, 1)
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, 1)
        XCTAssertEqual(view.invokedConfigureCategoryLabelParameters?.text, "kebap")
        XCTAssertEqual(view.invokedConfigureRestaurantImageViewParameters?.imageUrl, URL.string("url"))
        XCTAssertEqual(view.invokedConfigurePointLabelParameters?.text, "9.5")
        XCTAssertEqual(view.invokedConfigureRestaurantPointBackgroundColorParameters?.color, .green)
    }
    
    func test_loadCell_WithNilViewModelParameters_InvokeRequiredMethods() {
        createNewRestaurantCellPresenter(with: .init(restaurantPointBackgroundColor: nil, restaurantImageUrl: nil, categoryTitle: nil, restaurantPoint: nil, restaurantName: nil, restaurantStatus: nil))
        
        XCTAssertEqual(view.invokedConfigureCategoryLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantPointBackgroundColorCount, .zero)
        XCTAssertEqual(view.invokedConfigurePointLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, .zero)
        
        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigureCategoryLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureRestaurantImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantImageViewParameters?.imageUrl, .string(Constants.MealApi.somethingWentWrongUrl))
        XCTAssertEqual(view.invokedConfigureRestaurantPointBackgroundColorCount, 1)
        XCTAssertEqual(view.invokedConfigureRestaurantPointBackgroundColorParameters?.color, .brokenWhite)
        XCTAssertEqual(view.invokedConfigurePointLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureCellAppeareanceCount, 1)
    }
}
