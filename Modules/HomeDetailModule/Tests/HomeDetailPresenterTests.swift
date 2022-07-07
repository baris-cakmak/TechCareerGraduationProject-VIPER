//
//  HomeDetailPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 14.06.2022.
//

import XCTest
@testable import HomeDetailModule
@testable import HomeDetailModuleInterface
@testable import UserStorageManagerKit
@testable import CommonKit

final class HomeDetailPresenterTests: XCTestCase {

    var view: MockHomeDetailViewController!
    var router: MockHomeDetailRouter!
    var interactor: MockHomeDetailInteractor!
    var userStorageManager: MockUserStorage!
    var sut: HomeDetailPresenter!
    
    private func createSut(with homedetailViewModel: MealViewModel) {
        sut = .init(
            view: view,
            interactor: interactor,
            router: router,
            homeDetailViewModel: homedetailViewModel,
            userStorageManager: userStorageManager
        )
    }
    
    override func setUp() {
        view = MockHomeDetailViewController()
        router = MockHomeDetailRouter()
        interactor = MockHomeDetailInteractor()
        userStorageManager = MockUserStorage()
        sut = .init(view: view, interactor: interactor, router: router, homeDetailViewModel: .init(mealName: "mealName", mealImageUrl: URL.string("mealImageUrl"), mealPrice: "mealPrice", mealDesc: "mealDesc"), userStorageManager: userStorageManager)
    }
    
    override func tearDown() {
        view = nil
        router = nil
        interactor = nil
        sut = nil
    }
    
    func test_viewDidLoad_NotNilMealViewModel_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureStepperViewCount, .zero)
        XCTAssertEqual(view.invokedSetBackgroundColorCount, .zero)
        XCTAssertEqual(view.invokedConfigureDescriptionLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureStepperViewCount, 1)
        XCTAssertEqual(view.invokedSetBackgroundColorCount, 1)
        XCTAssertEqual(view.invokedConfigureDescriptionLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, 1)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, 1)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, 1)
        XCTAssertEqual(view.invokedConfigureDescriptionLabelParameters?.text, "mealDesc")
        XCTAssertEqual(view.invokedConfigureMealNameLabelParameters?.text, "mealName")
        XCTAssertEqual(view.invokedConfigureMealImageViewParameters?.url, URL(string: "mealImageUrl"))
        XCTAssertEqual(view.invokedConfigurePriceLabelParameters?.text, "₺ mealPrice")
    }
    func test_viewDidLoad_WihNilMealViewModelParameters_InvokeRequiredMethods() {
        createSut(with: .init())
        
        XCTAssertEqual(view.invokedConfigureStepperViewCount, .zero)
        XCTAssertEqual(view.invokedSetBackgroundColorCount, .zero)
        XCTAssertEqual(view.invokedConfigureDescriptionLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureStepperViewCount, 1)
        XCTAssertEqual(view.invokedSetBackgroundColorCount, 1)
        XCTAssertEqual(view.invokedConfigureDescriptionLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealNameLabelCount, .zero)
        XCTAssertEqual(view.invokedConfigureMealImageViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePriceLabelCount, .zero)
        XCTAssertNil(view.invokedConfigureDescriptionLabelParameters?.text)
        XCTAssertNil(view.invokedConfigureMealNameLabelParameters?.text)
        XCTAssertNil(view.invokedConfigureMealImageViewParameters?.url)
        XCTAssertNil(view.invokedConfigurePriceLabelParameters?.text)
    }
    
    func test_handleMealAddToCart_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        
        XCTAssertEqual(router.invokedPopToHomeViewCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)

        sut.handleMealAddToCart(result: .failure(error))
        
        XCTAssertEqual(router.invokedPopToHomeViewCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    
    func test_handleMealAddToCart_WithSuccessResult_InvokeRequiredMethods() {
        XCTAssertEqual(router.invokedPopToHomeViewCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleMealAddToCart(result: .success(.init(success: .zero, message: .init())))
        
        XCTAssertEqual(router.invokedPopToHomeViewCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
    }
    
    func test_calculatePrice_ByStepperValue_WithValidMealPrice_InvokeRequiredMethods() {
        createSut(with: .init())

        XCTAssertEqual(view.invokedDidPriceChangedCount, .zero)
        
        sut.calculatePrice(by: 2)
        
        XCTAssertEqual(view.invokedDidPriceChangedCount, .zero)
    }
    
    func test_calculatePrce_ByStepperValue_WithValidMealPrice_InvokeRequiredMethods() {
        createSut(with: .init(mealPrice: "2"))
        
        XCTAssertEqual(view.invokedDidPriceChangedCount, .zero)
        
        sut.calculatePrice(by: 2)
        
        XCTAssertEqual(view.invokedDidPriceChangedCount, 1)
        XCTAssertEqual(view.invokedDidPriceChangedParameters?.price, "₺ 4")
    }
    
    func test_addMealsToCartInApi_WithOrderCount_ByValidViewModelAndUserStorage_InvokeRequiredMethods() {
        createSut(with: .init(mealName: "mealName", mealImageUrl: .init(string: "mealImageUrlString"), mealPrice: "2", mealDesc: "mealDesc"))
        userStorageManager.stubbedGetUserEmailForMealAPIResult = "username"
        XCTAssertEqual(userStorageManager.invokedGetUserEmailForMealAPICount, 0)
        XCTAssertEqual(interactor.invokedRequestModelSetterCount, .zero)
        XCTAssertEqual(interactor.invokedAddMealsToCartCount, .zero)
        
        sut.addMealsToCartInApi(orderCount: 2)
        
        XCTAssertEqual(userStorageManager.invokedGetUserEmailForMealAPICount, 1)
        XCTAssertEqual(interactor.invokedRequestModelSetterCount, 1)
        XCTAssertEqual(interactor.invokedAddMealsToCartCount, 1)
        XCTAssertEqual(interactor.invokedRequestModel?.mealName, "mealName")
        XCTAssertEqual(interactor.invokedRequestModel?.username, "username")
        XCTAssertEqual(interactor.invokedRequestModel?.orderCount, Int("2"))
        XCTAssertEqual(interactor.invokedRequestModel?.mealPrice, 2)
        XCTAssertEqual(interactor.invokedRequestModel?.mealImageName, "mealImageUrlString")
        XCTAssertEqual(interactor.invokedAddMealsToCartCount, 1)
    }
    
    func test_addMealsToCartInApi_WithOrderCount_WithInvalidMealViewModel_InvokeRequiredMethods() {
        createSut(with: .init())
        
        XCTAssertEqual(interactor.invokedRequestModelSetterCount, .zero)
        XCTAssertEqual(interactor.invokedAddMealsToCartCount, .zero)
    
        sut.addMealsToCartInApi(orderCount: 2)
        
        XCTAssertEqual(interactor.invokedRequestModelSetterCount, .zero)
        XCTAssertEqual(interactor.invokedAddMealsToCartCount, .zero)
    }
}
