//
//  ProfilePresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import XCTest
@testable import ProfileModule
@testable import CommonKit

final class ProfilePresenterTests: XCTestCase {
    var view: MockProfileViewController!
    var interactor: MockProfileInteractor!
    var router: MockProfileRouter!
    var sut: ProfilePresenter!
    
    override func setUp() {
        view = MockProfileViewController()
        interactor = MockProfileInteractor()
        router = MockProfileRouter()
        sut = .init(view: view, interactor: interactor, router: router)
    }
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
    }
    func test_viewDidLoad_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedConfigureProfilePhotoCount, .zero)
        XCTAssertEqual(view.invokedConfigureRightBarButtonItemCount, .zero)
        XCTAssertEqual(view.invokedSetNavigationItemTitleCount, .zero)
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertEqual(interactor.invokedFetchUserCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureProfilePhotoCount, 1)
        XCTAssertEqual(view.invokedConfigureRightBarButtonItemCount, 1)
        XCTAssertEqual(view.invokedSetNavigationItemTitleParameters?.title, "Profile")
        XCTAssertEqual(view.invokedSetNavigationItemTitleCount, 1)
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
        XCTAssertEqual(interactor.invokedFetchUserCount, 1)
    }
    func test_didTapToLogout_InvokeRequiredMethods() {
        XCTAssertEqual(interactor.invokedLogoutTheUserCount, .zero)
        
        sut.didTapToLogout()
        
        XCTAssertEqual(interactor.invokedLogoutTheUserCount, 1)
    }
    func test_handleError_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleError(error)
        
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    func test_handleFetchUser_WithSuccessResult_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedUpdateViewCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleFetchUser(result: .success(.init(dictionary: [
            "username": "peace",
            "email": "baris",
            "profileImageUrl": "imageUrlString",
            "uid": "000"
        ])))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedUpdateViewCount, 1)
        XCTAssertEqual(view.invokedUpdateViewParameters?.viewModel.username, "peace")
        XCTAssertEqual(view.invokedUpdateViewParameters?.viewModel.email, "baris")
        XCTAssertEqual(view.invokedUpdateViewParameters?.viewModel.profileImage, .string("imageUrlString"))
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
    }
    func test_handleFetchUser_WithSuccessResult_IfReturnedImageUrlIsInvalid_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedUpdateViewCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleFetchUser(result: .success(.init(dictionary: [
            "username": "peace",
            "email": "baris",
            "uid": "0"
        ])))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedUpdateViewCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertEqual(view.invokedUpdateViewParameters?.viewModel.username, "peace")
        XCTAssertEqual(view.invokedUpdateViewParameters?.viewModel.email, "baris")
        XCTAssertEqual(view.invokedUpdateViewParameters?.viewModel.profileImage, .string(Constants.MealApi.somethingWentWrongUrl))
    }
    func test_handleFetchUser_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertEqual(view.invokedUpdateViewCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleFetchUser(result: .failure(error))
        
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertEqual(view.invokedUpdateViewCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    func test_handleLogOutUser_WhenResultIsFailure_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertEqual(router.invokedChangeWindowAsLoginCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleLogOutUser(result: .failure(error))
        
        XCTAssertEqual(router.invokedChangeWindowAsLoginCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    func test_handleLogoutUser_WhenResultIsSuccess_InvokeRequiredMethods() {
        XCTAssertEqual(router.invokedChangeWindowAsLoginCount, .zero)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleLogOutUser(result: .success(()))
        
        XCTAssertEqual(router.invokedChangeWindowAsLoginCount, 1)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
    }
}
