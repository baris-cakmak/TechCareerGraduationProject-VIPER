//
//  CartCellPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import XCTest
@testable import CartModule
@testable import CommonKit

final class CartCellPresenterTests: XCTestCase {
    var view: MockCartCellView!
    var sut: CartCellPresenter!
    var delegate: MockCartCellDelegate!
    
    private func createSut(with viewModel: CartViewModel) {
        sut = .init(view: view, delegate: delegate, cartViewModel: viewModel)
    }
    
    override func setUp() {
        view = MockCartCellView()
        delegate = MockCartCellDelegate()
        sut = .init(
            view: view,
            delegate: delegate,
            cartViewModel: .init(
                cartId: 1,
                mealName: "name",
                mealPrice: 1,
                mealImageUrl: .string("imageUrlString"),
                mealDescription: "desc",
                stepperCurrentValue: 1,
                totalPrice: "1",
                stepperLeftButtonText: "-"
            )
        )
    }
    override func tearDown() {
        view = nil
        delegate = nil
        sut = nil
    }
    func test_cellDidLoad_WithNotNilParameters_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureStepperViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealDescriptionLabelCount, .zero)
        
        sut.cellDidLoad()
        
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelParameters?.text, "1")
        XCTAssertEqual(view.invokedConfigureStepperViewCount, 1)
        XCTAssertEqual(view.invokedConfigureStepperViewParameters?.currentValue, 1)
        XCTAssertEqual(view.invokedConfigureStepperViewParameters?.leftButtonText, "-")
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureMealImageViewParameters?.url, .string("imageUrlString"))
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealNameLabelParameters?.text, "name")
        XCTAssertEqual(view.invokedConfigureMealDescriptionLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealDescriptionLabelParameters?.text, "desc")
    }
    func test_cellDidLoad_WitNilParameters_InvokeRequiredMethods() {
        createSut(with: .init(cartId: .zero, mealName: "name", mealPrice: .zero, mealImageUrl: nil, mealDescription: .init(), stepperCurrentValue: .zero, totalPrice: "", stepperLeftButtonText: ""))
        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureStepperViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealDescriptionLabelCount, .zero)
        
        sut.cellDidLoad()

        XCTAssertEqual(view.invokedConfigureCellAppearanceCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelParameters?.text, "")
        XCTAssertEqual(view.invokedConfigureStepperViewCount, 1)
        XCTAssertEqual(view.invokedConfigureStepperViewParameters?.currentValue, 0)
        XCTAssertEqual(view.invokedConfigureStepperViewParameters?.leftButtonText, "")
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureMealImageViewParameters?.url, .string(Constants.MealApi.somethingWentWrongUrl))
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealNameLabelParameters?.text, "name")
        XCTAssertEqual(view.invokedConfigureMealDescriptionLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealDescriptionLabelParameters?.text, "")
    }
    func test_didStepperValueChanged_WitValueDifferentFromZero_InvokeRequiredParameters() {
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureStepperViewCount, .zero)
        XCTAssertEqual(delegate.invokedUpdateFooterForNewTotalPriceCount, .zero)
        
        sut.didStepperValueChanged(for: view, 3)
        
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureStepperViewCount, 1)
        XCTAssertEqual(delegate.invokedUpdateFooterForNewTotalPriceCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelParameters?.text, "₺ 3")
        XCTAssertEqual(view.invokedConfigureStepperViewParameters?.leftButtonText, "-")
        XCTAssertEqual(view.invokedConfigureStepperViewParameters?.currentValue, 3)
        XCTAssertEqual(delegate.invokedUpdateFooterForNewTotalPriceParameters?.cell, view)
        XCTAssertEqual(delegate.invokedUpdateFooterForNewTotalPriceParameters?.value, 3)
    }
    func test_didStepperValueChangedAsZero_InvokeRequiredMethods() {
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureStepperViewCount, .zero)
        XCTAssertEqual(delegate.invokedUpdateFooterForNewTotalPriceCount, .zero)
        
        sut.didStepperValueChanged(for: view, 0)
        
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealCount, 1)
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealParameters?.cell, view)
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealParameters?.cartId, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureStepperViewCount, .zero)
        XCTAssertEqual(delegate.invokedUpdateFooterForNewTotalPriceCount, .zero)
    }
    func test_deleteMeal_ForCell_InvokeRequiredMethods() {
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealCount, .zero)
        
        sut.deleteMeal(for: view)
        
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealCount, 1)
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealParameters?.cartId, 1)
        XCTAssertEqual(delegate.invokedDidUserDecidedToDeleteMealParameters?.cell, view)
    }
}
