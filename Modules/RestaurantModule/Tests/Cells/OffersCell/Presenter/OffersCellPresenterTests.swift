//
//  OffersCellPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 26.05.2022.
//

import XCTest
@testable import RestaurantModule
@testable import CommonKit

final class OffersCellPresenterTests: XCTestCase {
    var sut: OffersPresenter!
    var view: MockOffersCell!
    
    private func createOfferPresenter(offerViewModel: OfferViewModel) {
        sut = .init(offerViewModel: offerViewModel, view: view)
    }
    override func setUp() {
        view = .init()
        sut = .init(offerViewModel: .init(), view: view)
    }
    override func tearDown() {
        view = nil
        sut = nil
    }
    func test_loadCell_WithNotNilViewModels_InvokeRequiredMethods() {
        createOfferPresenter(offerViewModel: .init(title: "title", imageUrl: .init(string: "imageUrlString")))
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, .zero)
        XCTAssertEqual(view.invokedConfigureOfferTitleLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureOfferImageViewCount, .zero)

        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, 1)
        XCTAssertEqual(view.invokedConfigureOfferTitleLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureOfferImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureOfferTitleLabelParameters?.text, "title")
        XCTAssertEqual(view.invokedConfigureOfferImageViewParameters?.url, .init(string: "imageUrlString"))
    }
    func test_loadCell_WithNotValidViewModelParameters_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, .zero)
        XCTAssertEqual(view.invokedConfigureOfferTitleLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureOfferImageViewCount, .zero)
        
        sut.loadCell()
        
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, 1)
        XCTAssertEqual(view.invokedConfigureOfferTitleLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureOfferImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureOfferImageViewParameters?.url, .string(Constants.MealApi.somethingWentWrongUrl))
    }
}
