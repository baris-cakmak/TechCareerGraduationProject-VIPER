//
//  LoginPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 7.06.2022.
//

import XCTest
@testable import LoginModule
@testable import SignInValidatorKit

final class LoginPresenterTests: XCTestCase {
    var view: MockLoginViewController!
    var interactor: MockLoginInteractor!
    var router: MockLoginRouter!
    var signInValidator: MockSignInValidator!
    var sut: LoginPresenter!
    
    override func setUp() {
        view = MockLoginViewController()
        interactor = MockLoginInteractor()
        router = MockLoginRouter()
        signInValidator = MockSignInValidator()
        sut = LoginPresenter(view: view, interactor: interactor, router: router, signInValidator: signInValidator)
    }
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
    }
    
    func test_viewDidLoad_InvokeRequiredMethods() {
        XCTAssertFalse(view.invokedConfigureKeyboardNotifications)
        XCTAssertFalse(view.invokedSetupTextFieldDelegates)
        XCTAssertFalse(view.invokedConfigureTapGesture)
        XCTAssertEqual(view.invokedConfigureKeyboardNotificationsCount, .zero)
        XCTAssertEqual(view.invokedSetupTextFieldDelegatesCount, .zero)
        XCTAssertEqual(view.invokedConfigureTapGestureCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(view.invokedConfigureKeyboardNotifications)
        XCTAssertTrue(view.invokedSetupTextFieldDelegates)
        XCTAssertTrue(view.invokedConfigureTapGesture)
        XCTAssertEqual(view.invokedConfigureKeyboardNotificationsCount, 1)
        XCTAssertEqual(view.invokedSetupTextFieldDelegatesCount, 1)
        XCTAssertEqual(view.invokedConfigureTapGestureCount, 1)
    }
    func test_didUserTappedToSignUp_ShowSignUpPage() {
        XCTAssertFalse(router.invokedShowSignUpPage)
        XCTAssertEqual(router.invokedShowSignUpPageCount, .zero)
        
        sut.didUserTappedToSignUp()
        
        XCTAssertTrue(router.invokedShowSignUpPage)
        XCTAssertEqual(router.invokedShowSignUpPageCount, 1)
    }
    
    func test_didUserTappedToLogin_WithNotValidEmailAndPassword_InvokeRequiredMethods() {
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertNil(signInValidator.invokedSignInModel)
        XCTAssertFalse(signInValidator.invokedSignInModelSetter)
        XCTAssertFalse(signInValidator.invokedSignInModelGetter)
        XCTAssertEqual(signInValidator.invokedSignInModelGetterCount, .zero)
        XCTAssertFalse(signInValidator.invokedValidateAll)
        XCTAssertEqual(
            signInValidator.invokedValidateAllCount,
            .zero
        )
        XCTAssertFalse(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertFalse(interactor.invokedLogUserIn)
        XCTAssertEqual(interactor.invokedLogUserInCount, .zero)
        
        sut.didUserTappedToLogIn(email: nil, password: nil)
        
        XCTAssertTrue(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, "One of The Field is missing")
        XCTAssertNil(signInValidator.invokedSignInModel)
        XCTAssertFalse(signInValidator.invokedSignInModelSetter)
        XCTAssertFalse(signInValidator.invokedSignInModelGetter)
        XCTAssertEqual(signInValidator.invokedSignInModelGetterCount, .zero)
        XCTAssertFalse(signInValidator.invokedValidateAll)
        XCTAssertEqual(
            signInValidator.invokedValidateAllCount,
            .zero
        )
        XCTAssertFalse(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertFalse(interactor.invokedLogUserIn)
        XCTAssertEqual(interactor.invokedLogUserInCount, .zero)
    }
    func test_didUserTappedToLogin_WithEmptyParameter_ThrowAnMissingFieldError_CallOnlyRequiredMethods() {
        signInValidator.stubbedValidateAllError = SignInErrors.missingField
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertNil(signInValidator.invokedSignInModel)
        XCTAssertFalse(signInValidator.invokedSignInModelSetter)
        XCTAssertFalse(signInValidator.invokedSignInModelGetter)
        XCTAssertEqual(signInValidator.invokedSignInModelGetterCount, .zero)
        XCTAssertFalse(signInValidator.invokedValidateAll)
        XCTAssertEqual(
            signInValidator.invokedValidateAllCount,
            .zero
        )
        XCTAssertFalse(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertFalse(interactor.invokedLogUserIn)
        XCTAssertEqual(interactor.invokedLogUserInCount, .zero)

        sut.didUserTappedToLogIn(email: "", password: "")
        
        XCTAssertTrue(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, "One of The Field is missing")
        XCTAssertTrue(signInValidator.invokedSignInModelSetter)
        XCTAssertFalse(signInValidator.invokedSignInModelGetter)
        XCTAssertEqual(signInValidator.invokedSignInModelGetterCount, .zero)
        XCTAssertTrue(signInValidator.invokedValidateAll)
        XCTAssertEqual(
            signInValidator.invokedValidateAllCount,
            1
        )
        XCTAssertFalse(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertFalse(interactor.invokedLogUserIn)
        XCTAssertEqual(interactor.invokedLogUserInCount, .zero)
    }
    func test_didUserTappedToLogin_WithNoErrorThrownByValidator_CallOnlyRequiredFields() {
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertNil(signInValidator.invokedSignInModel)
        XCTAssertFalse(signInValidator.invokedSignInModelSetter)
        XCTAssertFalse(signInValidator.invokedSignInModelGetter)
        XCTAssertEqual(signInValidator.invokedSignInModelGetterCount, .zero)
        XCTAssertFalse(signInValidator.invokedValidateAll)
        XCTAssertEqual(
            signInValidator.invokedValidateAllCount,
            .zero
        )
        XCTAssertFalse(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureAnimationCount, .zero)
        XCTAssertFalse(interactor.invokedLogUserIn)
        XCTAssertEqual(interactor.invokedLogUserInCount, .zero)
        
        sut.didUserTappedToLogIn(email: "email", password: "password")
        
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertNotNil(signInValidator.invokedSignInModel)
        XCTAssertTrue(signInValidator.invokedSignInModelSetter)
        XCTAssertFalse(signInValidator.invokedSignInModelGetter)
        XCTAssertEqual(signInValidator.invokedSignInModelGetterCount, .zero)
        XCTAssertTrue(signInValidator.invokedValidateAll)
        XCTAssertEqual(
            signInValidator.invokedValidateAllCount,
            1
        )
        XCTAssertTrue(view.invokedConfigureAnimation)
        XCTAssertEqual(view.invokedConfigureAnimationCount, 1)
        XCTAssertTrue(interactor.invokedLogUserIn)
        XCTAssertEqual(interactor.invokedLogUserInCount, 1)
    }
    func test_handleLoginAttempt_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedChangeWindowAsMainTab)
        XCTAssertEqual(router.invokedChangeWindowAsMainTabCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleLoginAttempt(result: .failure(error))
        
        XCTAssertTrue(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertFalse(router.invokedChangeWindowAsMainTab)
        XCTAssertEqual(router.invokedChangeWindowAsMainTabCount, .zero)
        XCTAssertTrue(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
    }
    func test_handleLoginAttempt_WithSuccessCase_InvokeRequiredFields() {
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedChangeWindowAsMainTab)
        XCTAssertEqual(router.invokedChangeWindowAsMainTabCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleLoginAttempt(result: .success(()))
        
        XCTAssertTrue(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertTrue(router.invokedChangeWindowAsMainTab)
        XCTAssertEqual(router.invokedChangeWindowAsMainTabCount, 1)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
    }
    func test_changeOriginYPointOfView_InvokeDesiredMethods() {
        XCTAssertFalse(view.invokedSetOriginYPointOfTheView)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewCount, .zero)
        XCTAssertFalse(view.invokedHideNavigationItemBackButtonItem)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemCount, .zero)
        
        sut.changeOriginYPointOfView(with: 1, hideBackButton: true, animated: true)
        
        XCTAssertTrue(view.invokedSetOriginYPointOfTheView)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewCount, 1)
        XCTAssertTrue(view.invokedHideNavigationItemBackButtonItem)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemCount, 1)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewParameters?.yPoint, 1)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemParameters?.animated, true)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemParameters?.hide, true)
    }
    func test_moveBackToDefaultYPoint_SetYPointOfTheViewByZero_InvokeRequiredMethods() {
        XCTAssertFalse(view.invokedSetOriginYPointOfTheView)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewCount, .zero)
        XCTAssertFalse(view.invokedHideNavigationItemBackButtonItem)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemCount, .zero)
        
        sut.moveBackToDefaultYPoint(hideBackButton: true, animated: true)
        
        XCTAssertTrue(view.invokedSetOriginYPointOfTheView)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewCount, 1)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewParameters?.yPoint, .zero)
        XCTAssertTrue(view.invokedHideNavigationItemBackButtonItem)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemCount, 1)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemParameters?.hide, true)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemParameters?.animated, true)
    }
}
