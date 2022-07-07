//
//  CartPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 16.06.2022.
//

import XCTest
@testable import CartModule
@testable import CommonKit
@testable import UserStorageManagerKit
@testable import DependencyManagerKit

final class CartPresenterTests: XCTestCase {
    var view: MockCartViewController!
    var interactor: MockCartInteractor!
    var router: MockCartRouter!
    var sut: CartPresenter!
    var userStorageManager: MockUserStorage!
    var fakeMealCartModels: [MealCart]!
    
    override func setUp() {
        view = MockCartViewController()
        interactor = MockCartInteractor()
        router = MockCartRouter()
        
        userStorageManager = MockUserStorage()
        sut = .init(view: view, interactor: interactor, router: router, userStorageManager: userStorageManager)
        fakeMealCartModels = [.init(cartMealId: "1", cartMealName: "name", cartMealImageName: "imageUrlString", cartMealPrice: "2", cartMealOrderCount: "3", username: "peace")]
        continueAfterFailure = false
    }
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
        userStorageManager = nil
    }
    func test_viewDidLoad_InvokeRequiredMethods() {
        userStorageManager.stubbedGetUserEmailForMealAPIResult = "username"

        XCTAssertEqual(view.invokedConfigureMealCollectionViewCount, .zero)
        XCTAssertEqual(view.invokedConfigureBarButtonItemCount, .zero)
        XCTAssertEqual(view.invokedSetNavigationItemTitleCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureMealCollectionViewCount, 1)
        XCTAssertEqual(view.invokedConfigureBarButtonItemCount, 1)
        XCTAssertEqual(view.invokedSetNavigationItemTitleCount, 1)
        XCTAssertEqual(view.invokedSetNavigationItemTitleParameters?.title, "Cart")
    }
    func test_viewDidAppear_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedRemoveBadgeNumberFromTabBarCount, .zero)
        
        sut.viewDidAppear()
        
        XCTAssertEqual(view.invokedRemoveBadgeNumberFromTabBarCount, 1)
    }
    func test_viewWillAppear_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertEqual(interactor.invokedFetchMealsAtTheCartCount, .zero)
        
        sut.viewWillAppear()
        
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
        XCTAssertEqual(interactor.invokedFetchMealsAtTheCartCount, 1)
    }
    func test_viewWillDisappear_InvokeRequiredMethods() {
        XCTAssertEqual(interactor.invokedFetchMealsAtTheCartForBadgeValueCount, .zero)
        
        sut.viewWillDisappear()
        
        XCTAssertEqual(interactor.invokedFetchMealsAtTheCartForBadgeValueCount, 1)
    }
    
    func test_popBackIfNumberOfItemsEqualToZero_WithNonZeroItem_InvokeRequiredMethods() {
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: 200)))
        
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.popBackIfNumberOfItemsEqualToZero()
        
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
    }
    func test_popBackIfNumberOfItemsEqualToZero_WithZeroCartMealItem_ShowFirstTab() {
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: [], success: .zero)))
        
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.popBackIfNumberOfItemsEqualToZero()
        
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
    }
    func test_numberOfRowsInSection_WithSuccessfulFetching_ReturnCartMealCountAsViewModelCount() {
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
        
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
    }
    func test_numberOfRowsInSection_WithFailureResult_ReturnNumberOfCountAsZero() {
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
        
        sut.didFetchMealsAtTheCart(result: .failure(NSError(domain: "", code: .zero)))
        
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
    }
    func test_deleteMealFromTheCart_WithValid_AtIndexPathWithCartIdValues_InvokeRequiredMethods() {
        userStorageManager.stubbedGetUserEmailForMealAPIResult = "username"
        
        XCTAssertEqual(interactor.invokedDeleteSingleMealCount, .zero)
        
        sut.deleteMealFromTheCart(at: .init(item: .zero, section: .zero), with: .zero)
        
        XCTAssertEqual(interactor.invokedDeleteSingleMealCount, 1)
        XCTAssertEqual(interactor.invokedDeleteSingleMealParameters?.indexPath, .init(item: .zero, section: .zero))
        XCTAssertEqual(interactor.invokedDeleteSingleMealParameters?.mealDeleteRequestModel.cartId, .zero)
        XCTAssertEqual(interactor.invokedDeleteSingleMealParameters?.mealDeleteRequestModel.username, "username") 
    }
    func test_deleteMealFromTheCart_WithInvalidParameters_DoNotInvokeMethods() {
        XCTAssertEqual(interactor.invokedDeleteSingleMealCount, .zero)
        
        sut.deleteMealFromTheCart(at: nil, with: .zero)
        
        XCTAssertEqual(interactor.invokedDeleteSingleMealCount, .zero)
    }
    func test_deleteAllItemsAtTheCart_InvokeRequiredMethods() {
        let expectation = expectation(description: "deletingAllTheMeals")
        expectation.isInverted = true
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertEqual(interactor.invokedDeleteAllMealsCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.deleteAllItemsAtTheCart()
        
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
        XCTAssertEqual(interactor.invokedDeleteAllMealsCount, 1)
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 2)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
    }
    func test_orderMealsAtTheCart_InvokeRequiredMethods() {
        XCTAssertEqual(router.invokedShowOrderDecisionPopUpCount, .zero)
        
        sut.orderMealsAtTheCart()
        
        XCTAssertEqual(router.invokedShowOrderDecisionPopUpCount, 1)
    }
    func test_didTapDeleteAll_InvokeRequiredMethods() {
        XCTAssertEqual(router.invokedShowDeleteDecisionPopUpCount, .zero)
        
        sut.didTapDeleteAll()
        
        XCTAssertEqual(router.invokedShowDeleteDecisionPopUpCount, 1)
    }
    func test_didErrorOccured_WithOkayToPresentTheError_WithNonZeroMealCartResult_InvokeRequriredMethods() {
        let error = NSError(domain: "", code: .zero)
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didErrorOccured(error: error, isOkayToPresentTheError: true)
        
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    func test_getAllThePricesInTheCart_InvokeRequiredMethods() {
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: [
            .init(cartMealId: "1", cartMealName: "", cartMealImageName: "", cartMealPrice: "1", cartMealOrderCount: "2", username: ""),
            .init(cartMealId: "2", cartMealName: "", cartMealImageName: "", cartMealPrice: "3", cartMealOrderCount: "4", username: "")
        ], success: .zero)))
        XCTAssertEqual(sut.numberOfRowsInSection(), 2)
        
        XCTAssertEqual(sut.getAllThePricesInTheCart(), [2, 12])
    }
    func test_changeCartViewModel_ValidAtIndexPathWithStepperCount_InvokeRequiredMethods() {
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, .zero)
        XCTAssertEqual(sut.cartViewModel(at: .init(item: .zero, section: .zero)).stepperCurrentValue, 3)
        
        sut.changeCartViewModel(at: .init(item: .zero, section: .zero), stepperCount: 4)
        
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, 1)
        XCTAssertEqual(sut.cartViewModel(at: .init(item: .zero, section: .zero)).stepperCurrentValue, 4)
    }
    func test_changeCartViewModel_WithNilIndexPath_DoNotInvokeMethods() {
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, .zero)
        
        sut.changeCartViewModel(at: nil, stepperCount: 4)
        
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, .zero)
    }
    func test_didDeleteMeals_WithSuccessResult_DeletedCartViewModelCountZero_InvokeRequiredMethods() {
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(view.invokedDeleteItemsCount, .zero)
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.didDeleteMeals(result: .success(.init(success: .zero, message: "success")), at: .init(item: .zero, section: .zero))
        
        XCTAssertEqual(view.invokedDeleteItemsCount, 1)
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, 1)
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
    }
    func test_didDeleteMeals_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedDeleteItemsCount, .zero)
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didDeleteMeals(result: .failure(error), at: .init(item: .zero, section: .zero))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedDeleteItemsCount, .zero)
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
    }
    func test_didDeleteMeals_WithSuccessResult_DeletedCartViewModelCountNotEqualToZero_InvokeRequiredMethods() {
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: [
            .init(cartMealId: "1", cartMealName: "", cartMealImageName: "", cartMealPrice: "1", cartMealOrderCount: "2", username: ""),
            .init(cartMealId: "2", cartMealName: "", cartMealImageName: "", cartMealPrice: "3", cartMealOrderCount: "4", username: "")
        ], success: .zero)))
        
        XCTAssertEqual(view.invokedDeleteItemsCount, .zero)
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), 2)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.didDeleteMeals(result: .success(.init(success: .zero, message: "success")), at: .init(item: .zero, section: .zero))
        
        XCTAssertEqual(view.invokedDeleteItemsCount, 1)
        XCTAssertEqual(view.invokedUpdateCheckoutFooterPriceCount, 1)
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
    }
    func test_didFetchMealsAtTheCart_WithSuccessResult_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        let viewModel: CartViewModel = sut.cartViewModel(at: .init(item: .zero, section: .zero))
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        XCTAssertEqual(viewModel.cartId, 1)
        XCTAssertEqual(viewModel.mealName, "name")
        XCTAssertEqual(viewModel.mealImageUrl, .init(string: "imageUrlString"))
        XCTAssertEqual(viewModel.mealPrice, 2)
        XCTAssertEqual(viewModel.stepperCurrentValue, 3)
    }
    func test_didFetchMealsatTheCart_WithSuccessResult_InvalidBackendResponse_ReturnFatalError() {
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: [.init(cartMealId: "", cartMealName: "", cartMealImageName: "", cartMealPrice: "", cartMealOrderCount: "", username: "")], success: .zero)))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
    }
    func test_didfetchMealsAtTheCart_WithFailure_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
        
        sut.didFetchMealsAtTheCart(result: .failure(error))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
    }
    func test_didFetchMealsAtTheCartForBadge_WithSuccesResult_NotEmptyResult_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.didFetchMealsAtTheCartForBadge(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarParameters?.value, "1")
    }
    func test_didFetchMealsAtTheCartBadge_WithSuccessResult_ZeroItems_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.didFetchMealsAtTheCartForBadge(result: .success(.init(mealCart: [], success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        XCTAssertNil(view.invokedUpdateBadgeValueOfCartTabBarParameters?.value)
    }
    func test_didFetchMealsAtTheCartForBadge_WithFailureResult() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.didFetchMealsAtTheCartForBadge(result: .failure(error))
        
        XCTAssertEqual(view.invokedUpdateBadgeValueOfCartTabBarCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
    }
    func test_didUserDecidedToGetTheOrder_InvokerRequiredMethods() {
        let expectation = expectation(description: "deletingAllTheMeals")
        expectation.isInverted = true
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertEqual(interactor.invokedDeleteAllMealsCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.didUserDecidedToGetTheOrder()
        
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
        XCTAssertEqual(interactor.invokedDeleteAllMealsCount, 1)
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 2)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
    }
    func test_didUserDecidedToGetTheOrder_InvokeRequiredMethods() {
        let expectation = expectation(description: "deletingAllTheMeals")
        expectation.isInverted = true
        sut.didFetchMealsAtTheCart(result: .success(.init(mealCart: fakeMealCartModels, success: .zero)))
        
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertEqual(interactor.invokedDeleteAllMealsCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, .zero)
        
        sut.didDeleteAllRequested()
        
        wait(for: [expectation], timeout: 0.5)
    
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
        XCTAssertEqual(interactor.invokedDeleteAllMealsCount, 1)
        XCTAssertEqual(sut.numberOfRowsInSection(), 0)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 2)
        XCTAssertEqual(router.invokedShowFirstTabToAddMealCount, 1)
    }
}
