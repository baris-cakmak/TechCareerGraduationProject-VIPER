//
//  RestaurantPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 8.06.2022.
//

import XCTest
@testable import RestaurantModule
@testable import CommonKit

final class RestaurantPresenterTests: XCTestCase {
    var sut: RestaurantPresenter!
    var view: MockRestaurantViewController!
    var interactor: MockRestaurantInteractor!
    var router: MockRestaurantRouter!
    
    override func setUp() {
        view = MockRestaurantViewController()
        interactor = MockRestaurantInteractor()
        router = MockRestaurantRouter()
        sut = RestaurantPresenter(view: view, interactor: interactor, router: router)
    }
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
    }
    func test_viewDidLoad_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureRestaurantCollectionViewCount, .zero)
        XCTAssertEqual(view.invokedSetNavigationItemTitleCount, .zero)
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertEqual(interactor.invokedFetchOffersCount, .zero)
        XCTAssertEqual(interactor.invokedFetchNewRestaurantsCount, .zero)
        XCTAssertEqual(interactor.invokedFetchRestaurantsCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureRestaurantCollectionViewCount, 1)
        XCTAssertEqual(view.invokedSetNavigationItemTitleCount, 1)
        XCTAssertEqual(view.invokedSetNavigationItemTitleParameters?.title, "Restaurant")
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
        XCTAssertEqual(interactor.invokedFetchOffersCount, 1)
        XCTAssertEqual(interactor.invokedFetchNewRestaurantsCount, 1)
        XCTAssertEqual(interactor.invokedFetchRestaurantsCount, 1)
    }
    func test_numberOfRowInSectionOffer_ReturnItemCountThatIsFetched() {
        sut.didOfferCallFinished(.success([.init(id: 1, title: "title", imageUrlString: "imageUrlString")]))
        
        XCTAssertEqual(sut.numberOfRowsInSectionOffer(), 1)
    }
    func test_numberOfRowsInSectionNewResturant_ReturnItemCountAsExpected() {
        sut.didFetchNewRestaurants(.success([.init(id: 1, restaurantName: "name", category: .kebap, restaurantPoint: "1", status: .excellent, restaurantImageUrlString: "imageUrlString")]))
        
        XCTAssertEqual(sut.numberOfRowsInSectionNewRestaurant(), 1)
    }
    func test_numberOfRowsInSectionRestaurant_ReturnItemCountAsExpected() {
        sut.didFetchRestaurants(.success([.init(id: 1, restaurantName: "name", restaurantPoint: "1", adress: "adress", minimumPrice: "1", deliveryCost: "1", status: .excellent, restaurantImageUrl: "imageUrlString")]))
        
        XCTAssertEqual(sut.numberOfRowsInSectionRestaurant(), 1)
    }
    func test_goToHome_InvokeRequiredMethods() {
        XCTAssertEqual(router.invokedShowHomeCount, .zero)
        
        sut.goToHome()
        
        XCTAssertEqual(router.invokedShowHomeCount, 1)
    }
    func test_getOfferViewModel_AtIndexPath() {
        sut.didOfferCallFinished(.success([.init(id: 1, title: "title", imageUrlString: "imageUrlString")]))
        
        let viewModel = sut.getOfferViewModel(at: .init(item: .zero, section: .zero))
        XCTAssertEqual(viewModel.title, "title")
        XCTAssertEqual(viewModel.imageUrl, .init(string: "imageUrlString"))
    }
    func test_getResturantViewModel_AtIndexPath() {
        sut.didFetchRestaurants(.success([.init(id: 1, restaurantName: "name", restaurantPoint: "1", adress: "adress", minimumPrice: "1", deliveryCost: "1", status: .excellent, restaurantImageUrl: "imageUrlString")]))
        
        let viewModel = sut.getResturantViewModel(at: .init(item: .zero, section: .zero))
        XCTAssertEqual(viewModel.restaurantAdress, "adress")
        XCTAssertEqual(viewModel.restaurantDeliveryCost, "1")
        XCTAssertEqual(viewModel.restaurantImageUrl, .init(string: "imageUrlString"))
        XCTAssertEqual(viewModel.restaurantMinimumCost, "1")
        XCTAssertEqual(viewModel.restaurantPoint, "1")
        XCTAssertEqual(viewModel.restaurantPointBackgroundColor, .green)
    }
    func test_getNewRestaurantViewModel_AtIndexPath() {
        sut.didFetchNewRestaurants(.success([.init(id: 1, restaurantName: "name", category: .kebap, restaurantPoint: "1", status: .excellent, restaurantImageUrlString: "imageUrlString")]))
        
        let viewModel = sut.getNewRestaurantViewModel(at: .init(item: .zero, section: .zero))
        XCTAssertEqual(viewModel.restaurantPoint, "1")
        XCTAssertEqual(viewModel.categoryTitle, "Kebap")
        XCTAssertEqual(viewModel.restaurantName, "name")
        XCTAssertEqual(viewModel.restaurantStatus, .excellent)
        XCTAssertEqual(viewModel.restaurantPointBackgroundColor, .green)
        XCTAssertEqual(viewModel.restaurantImageUrl, .init(string: "imageUrlString"))
    }
    func test_didErrorOccrued_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didErrorOccured(error: error)
        
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, "Error due to ".appending(error.localizedDescription))
    }
    func test_didFetchNewRestaurants_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didFetchNewRestaurants(.failure(error))
        
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, "Error due to ".appending(error.localizedDescription))
    }
    func test_didFetchNewRestaurants_WithSuccessResult_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didFetchNewRestaurants(.success([.init(id: 1, restaurantName: "name", category: .kebap, restaurantPoint: "1", status: .excellent, restaurantImageUrlString: "imageUrlString")]))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
    }
    func test_didOfferCallFinished_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didOfferCallFinished(.failure(error))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, "Error due to ".appending(error.localizedDescription))
    }
    func test_didOfferCallFinished_WithSuccessResult_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didOfferCallFinished(.success([.init(id: 1, title: "title", imageUrlString: "imageUrlString")]))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
    }
    func test_didFetchRestaurants_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.didFetchRestaurants(.failure(error))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, "Error due to ".appending(error.localizedDescription))
    }
}
