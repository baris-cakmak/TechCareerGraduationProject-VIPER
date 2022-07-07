//
//  RootPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 18.06.2022.
//

import XCTest
@testable import RootModule
@testable import UserStorageManagerKit

final class RootPresenterTests: XCTestCase {
    var view: MockRootViewController!
    var interator: MockRootInteractor!
    var router: MockRootRouter!
    var sut: RootPresenter!
    var userStorageManager: MockUserStorage!
    
    override func setUp() {
        view = MockRootViewController()
        interator = MockRootInteractor()
        router = MockRootRouter()
        userStorageManager = MockUserStorage()
        sut = RootPresenter(view: view, interactor: interator, router: router, userStorageManager: userStorageManager)
    }
    override func tearDown() {
        view = nil
        interator = nil
        router = nil
        sut = nil
    }
    func test_viewWillAppear_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureGlobalNavigationAppereanceCount, .zero)
        XCTAssertEqual(interator.invokedCheckOnboardingSeenCount, .zero)
        
        sut.viewWillAppear()
        
        XCTAssertEqual(view.invokedConfigureGlobalNavigationAppereanceCount, 1)
        XCTAssertEqual(interator.invokedCheckOnboardingSeenCount, 1)
    }
    func test_showOnboardingModule_InvokeRequiredMethods() {
        XCTAssertEqual(router.invokedChangeWindowAsOnboardingCount, .zero)
        
        sut.showOnboardingModule()
        
        XCTAssertEqual(router.invokedChangeWindowAsOnboardingCount, 1)
    }
    func test_handleUserLoggedIn_WithSuccessfulResult_InvokeRequiredMethods() {
        XCTAssertEqual(userStorageManager.invokedSetUserEmailForMealAPICount, .zero)
        XCTAssertEqual(router.invokedChangeWindowAsTabBarModuleCount, .zero)
        XCTAssertEqual(router.invokedChangeWindowAsLoginModuleCount, .zero)
        
        sut.handleUserLoggedIn(result: .success(.init(dictionary: ["username": "username", "email": "email"])))
        
        XCTAssertEqual(userStorageManager.invokedSetUserEmailForMealAPICount, 1)
        XCTAssertEqual(userStorageManager.invokedSetUserEmailForMealAPIParameters?.username, "email")
        XCTAssertEqual(router.invokedChangeWindowAsTabBarModuleCount, 1)
        XCTAssertEqual(router.invokedChangeWindowAsLoginModuleCount, .zero)
    }
    func test_handleUserLoggedIn_WithFailureResult_InvokeRequiredMethods() {
        XCTAssertEqual(userStorageManager.invokedSetUserEmailForMealAPICount, .zero)
        XCTAssertEqual(router.invokedChangeWindowAsTabBarModuleCount, .zero)
        XCTAssertEqual(router.invokedChangeWindowAsLoginModuleCount, .zero)
        
        sut.handleUserLoggedIn(result: .failure(NSError(domain: "", code: .zero)))
        
        XCTAssertEqual(userStorageManager.invokedSetUserEmailForMealAPICount, .zero)
        XCTAssertEqual(router.invokedChangeWindowAsTabBarModuleCount, .zero)
        XCTAssertEqual(router.invokedChangeWindowAsLoginModuleCount, 1)
    }
}
