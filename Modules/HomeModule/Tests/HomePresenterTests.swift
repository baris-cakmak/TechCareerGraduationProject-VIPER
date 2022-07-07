//
//  HomePresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 9.06.2022.
//

import XCTest
@testable import HomeModule
@testable import CommonKit

final class HomePresenterTests: XCTestCase {
    var view: MockHomeViewController!
    var router: MockHomeRouter!
    var interactor: MockHomeInteractor!
    var sut: HomePresenter!
    
    var stubMealResponseModel: MealResponseModel = .init(meal: [.init(mealId: "1", mealName: "mealName", mealImageUrlString: "mealImageUrlString", mealPrice: "mealPrice", mealDesc: "mealDesc")], success: .zero)
   
    override func setUp() {
        view = MockHomeViewController()
        router = MockHomeRouter()
        interactor = MockHomeInteractor()
        sut = HomePresenter(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        view = nil
        router = nil
        interactor = nil
        sut = nil
    }
    
    func test_viewDidLoad_InvokeRequiredMethods() {
        XCTAssertFalse(view.invokedSetNavigationItemTitle)
        XCTAssertFalse(view.invokedConfigureMealCollectionView)
        XCTAssertFalse(view.invokedConfigureAnimation)
        XCTAssertFalse(interactor.invokedGetAllMeals)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(view.invokedSetNavigationItemTitle)
        XCTAssertTrue(view.invokedConfigureMealCollectionView)
        XCTAssertTrue(view.invokedConfigureAnimation)
        XCTAssertTrue(interactor.invokedGetAllMeals)
        XCTAssertEqual(view.invokedSetNavigationItemTitleParameters?.title, "Home")
    }
    
    func test_viewDidAppear_InvokeRequiredMethods() {
        XCTAssertFalse(interactor.invokedFetchMealsAtTheCart)
        
        sut.viewDidAppear()
        
        XCTAssertTrue(interactor.invokedFetchMealsAtTheCart)
    }
    
    func test_numberOfRowsInSection_WithFailedResult_ReturnCountAsZero() {
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
        
        sut.handleFetchingAllMeals(result: .failure(NSError(domain: "error", code: -1)))

        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
    }
    
    func test_numberOfRowsInSection_WithSuccessResult_ReturnDtoCountAsViewModelCount() {
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
        
        sut.handleFetchingAllMeals(result: .success(stubMealResponseModel))
        
        XCTAssertEqual(sut.numberOfRowsInSection(), 1)
    }
    
    func test_getHomeViewModel_AtIndexPathWithNotNilResponse_ReturnViewModel() {
        sut.handleFetchingAllMeals(result: .success(stubMealResponseModel))
        
        let viewModel = sut.getHomeViewModel(at: .init(row: .zero, section: .zero))

        XCTAssertEqual(viewModel.mealName, "mealName")
        XCTAssertEqual(viewModel.mealImageUrl, URL(string: Constants.MealApi.apiImagesConstantUrlString.appending("mealImageUrlString")))
        XCTAssertEqual(viewModel.mealDesc, "mealDesc")
        XCTAssertEqual(viewModel.mealPrice, "mealPrice")
    }
    
    func test_goToHomeDetail_WithIndexPath_InvokeRequiredMethods() {
        sut.handleFetchingAllMeals(result: .success(stubMealResponseModel))
        
        XCTAssertEqual(router.invokedShowHomeDetailCount, .zero)
        
        sut.goToHomeDetail(with: .init(item: .zero, section: .zero))
        
        XCTAssertEqual(router.invokedShowHomeDetailCount, 1)
        XCTAssertEqual(router.invokedShowHomeDetailParameters?.mealViewModel.mealName, "mealName")
        XCTAssertEqual(router.invokedShowHomeDetailParameters?.mealViewModel.mealPrice, "mealPrice")
        XCTAssertEqual(router.invokedShowHomeDetailParameters?.mealViewModel.mealDesc, "mealDesc")
        XCTAssertEqual(router.invokedShowHomeDetailParameters?.mealViewModel.mealImageUrl, URL(string: Constants.MealApi.apiImagesConstantUrlString.appending("mealImageUrlString")))
    }
    
    func test_handleError_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, .zero)
        
        sut.handleError(error)
        
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
        XCTAssertNil(view.invokedUpdateBadgeCountOfCartTabBarParameters?.badgeValue)
    }
    
    func test_handleFetchingAllMeals_WithFailureResult_InvokeParameters() {
        let error = NSError(domain: "", code: .zero)
        
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleFetchingAllMeals(result: .failure(error))
        
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    
    func test_handleFetchingAllMeals_WithNotNilSuccessfullResults_InvokeRequiredParameters() {
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(router.invokedShowHomeDetailCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        
        sut.handleFetchingAllMeals(result: .success(stubMealResponseModel))
        
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(router.invokedShowHomeDetailCount, .zero)
        
        let homeViewModelCount = sut.numberOfRowsInSection()
        
        XCTAssertEqual(homeViewModelCount, 1)
    }
    
    func test_handleFetchingAllMeals_WithNilId_ThrowAnError_DoNotCreateViewModel_InvokeRequiredMethods() {
        let mealResponseModel: MealResponseModel = .init(meal: [.init(mealId: nil, mealName: "", mealImageUrlString: "", mealPrice: "", mealDesc: "")], success: .zero)
        
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleFetchingAllMeals(result: .success(mealResponseModel))

        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(sut.numberOfRowsInSection(), .zero)
    }
    
    func test_handleMealsAtTheCart_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, .zero)
        
        sut.handleMealsAtTheCart(result: .failure(error))
        
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, 1)
        XCTAssertNil(view.invokedUpdateBadgeCountOfCartTabBarParameters?.badgeValue)
    }
    
    func test_handleMealsAtTheCart_WithSuccessResult_NotEmptyMealCartResponse_InvokeRequiredParameters() {
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, .zero)
        
        sut.handleMealsAtTheCart(result: .success(.init(mealCart: [.init(cartMealId: "", cartMealName: "", cartMealImageName: "", cartMealPrice: "", cartMealOrderCount: "", username: "")], success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, 1)
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarParameters?.badgeValue, "1")
    }
    func test_handleMealsAtTheCart_WithSuccessResult_EmptyMealCartResponse_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, .zero)
        
        sut.handleMealsAtTheCart(result: .success(.init(mealCart: [], success: .zero)))
        
        XCTAssertEqual(view.invokedUpdateBadgeCountOfCartTabBarCount, 1)
        XCTAssertNil(view.invokedUpdateBadgeCountOfCartTabBarParameters?.badgeValue)
    }
}
