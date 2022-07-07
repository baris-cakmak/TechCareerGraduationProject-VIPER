//
//  MainTabBarPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 19.06.2022.
//

import XCTest
@testable import MainTabBarModule
@testable import CommonKit

final class MainTabBarPresenterTests: XCTestCase {
    var view: MockMainTabBarViewController!
    var interactor: MockMainTabBarInteractor!
    var router: MockMainTabBarRouter!
    var sut: MainTabBarPresenter!
    
    override func setUp() {
        view = MockMainTabBarViewController()
        interactor = MockMainTabBarInteractor()
        router = MockMainTabBarRouter()
        sut = .init(view: view, interactor: interactor, router: router)
    }
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
    }
    func test_viewWillAppear_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureTabBarAppeareanceCount, .zero)
        XCTAssertEqual(view.invokedConfigureViewControllersCount, .zero)
        XCTAssertEqual(interactor.invokedGetMealsAtTheCartCount, .zero)

        sut.viewWillAppear()
        
        XCTAssertEqual(view.invokedConfigureTabBarAppeareanceCount, 1)
        XCTAssertEqual(view.invokedConfigureViewControllersCount, 1)
        XCTAssertEqual(interactor.invokedGetMealsAtTheCartCount, 1)
    }
    func test_handleMealAtTheCart_WithSuccessResult_NonZeroMealCartResponse_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)
        
        sut.handleMealsAtTheCart(result: .success(.init(mealCart: [.init(cartMealId: "", cartMealName: "", cartMealImageName: "", cartMealPrice: "", cartMealOrderCount: "", username: "")], success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, 1)
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarParameters?.value, "1")
    }
    func test_handleMealAtTheCart_WithSuccessResult_WithZeroMealCartResponse_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)

        sut.handleMealsAtTheCart(result: .success(.init(mealCart: [], success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, 1)
        XCTAssertNil(view.invokedUpdateBadgeValueOfCartTabBarParameters?.value)
    }
    func test_handleMealsAtTheCart_WithFailureResult_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)
        
        sut.handleMealsAtTheCart(result: .failure(NSError(domain: "", code: .zero)))
        
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)
    }
}
