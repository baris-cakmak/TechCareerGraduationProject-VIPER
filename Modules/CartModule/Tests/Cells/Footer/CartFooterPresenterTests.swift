//
//  CartFooterPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 18.06.2022.
//

import XCTest
@testable import TechCareerGraduationProject
@testable import CartModule

final class CartFooterPresenterTests: XCTestCase {
    var view: MockFooterView!
    var delegate: MockCartFooterDelegate!
    var sut: CartFooterPresenter!
    
    override func setUp() {
        view = MockFooterView()
        delegate = MockCartFooterDelegate()
        sut = .init(view: view, delegate: delegate, footerViewModel: .init())
    }
    override func tearDown() {
        view = nil
        delegate = nil
        sut = nil
    }
    func test_calculateTotalPrice_OfPricesInCart_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedChangePriceCount, .zero)
        
        sut.calculateTotalPrice(of: [1, 2])
        
        XCTAssertEqual(view.invokedChangePriceCount, 1)
        XCTAssertEqual(view.invokedChangePriceParameters?.footerViewModel.totalPrice, "3")
    }
    func test_didTapOrderNow_InvokeRequiredMethods() {
        XCTAssertEqual(delegate.invokedDidTapOrderNowCount, .zero)
        
        sut.didTapOrderNow()
        
        XCTAssertEqual(delegate.invokedDidTapOrderNowCount, 1)
    }
}
