//
//  HomeCellPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import XCTest
@testable import HomeModule
@testable import CommonKit

final class HomeCellPresenterTests: XCTestCase {
    var view: MockHomeCellView!
    var sut: HomeCellPresenter!
    
    private func createHomeCellPresenter(mealViewModel: MealViewModel) {
        sut = .init(view: view, mealViewModel: mealViewModel)
    }
    
    override func setUp() {
        view = MockHomeCellView()
        sut = HomeCellPresenter(view: view, mealViewModel: .init())
    }
    override func tearDown() {
        view = nil
        sut = nil
    }
    func test_loadCell_WithValidMealViewModel_InvokeRequiredMethods() {
        createHomeCellPresenter(mealViewModel: .init(mealName: "name", mealImageUrl: .init(string: "imageUrlString"), mealPrice: "1", mealDesc: "desc"))
        
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, .zero)
        
        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelParameters?.text, "₺ ".appending("1"))
        XCTAssertEqual(view.invokedConfigureMealImageViewParameters?.url, .string("imageUrlString"))
        XCTAssertEqual(view.invokedConfigureMealNameLabelParameters?.text, "name")
    }
    func test_loadCell_WhenTheViewModelParametersAreInvalid_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, .zero)
        
        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, 1)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureMealImageViewParameters?.url, .string(Constants.MealApi.somethingWentWrongUrl))
    }
}
