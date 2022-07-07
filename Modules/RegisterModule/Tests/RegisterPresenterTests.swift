//
//  RegisterPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 24.05.2022.
//

import XCTest
import Lottie
@testable import RegisterModule
@testable import SignUpValidatorKit

final class RegisterPresenterTests: XCTestCase {
    var view: MockRegisterViewController!
    var sut: RegisterPresenter!
    var interactor: MockRegisterInteractor!
    var router: MockRegisterRouter!
    var signUpValidator: MockSignUpValidator!

    override func setUp() {
        view = MockRegisterViewController()
        interactor = MockRegisterInteractor()
        router = MockRegisterRouter()
        signUpValidator = MockSignUpValidator()
        sut = .init(view: view, interactor: interactor, router: router, signUpValidator: signUpValidator)
    }
    
    override func tearDown() {
        sut = nil
        router = nil
        interactor = nil
        view = nil
        signUpValidator = nil
    }
    
    func test_viewDidLoad_InvokeRequiredMethods() {
        XCTAssertFalse(view.invokedConfigureSignInContainer)
        XCTAssertFalse(view.invokedConfigureKeyboardNotifications)
        XCTAssertFalse(view.invokedSetupTextFieldDelegates)
        XCTAssertFalse(view.invokedConfigureTapGesture)
        XCTAssertEqual(view.invokedConfigureSignInContainerCount, .zero)
        XCTAssertEqual(view.invokedConfigureKeyboardNotificationsCount, .zero)
        XCTAssertEqual(view.invokedSetupTextFieldDelegatesCount, .zero)
        XCTAssertEqual(view.invokedConfigureSignInContainerCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(view.invokedConfigureSignInContainer)
        XCTAssertTrue(view.invokedConfigureKeyboardNotifications)
        XCTAssertTrue(view.invokedSetupTextFieldDelegates)
        XCTAssertTrue(view.invokedConfigureTapGesture)
        XCTAssertEqual(view.invokedConfigureSignInContainerCount, 1)
        XCTAssertEqual(view.invokedConfigureKeyboardNotificationsCount, 1)
        XCTAssertEqual(view.invokedSetupTextFieldDelegatesCount, 1)
        XCTAssertEqual(view.invokedConfigureSignInContainerCount, 1)
    }
    
    func test_didImageSelected_WithNotNilInfoAsSelectedImage_InvokeRequiredMethods() {
        let info: [UIImagePickerController.InfoKey: Any] = [.editedImage: UIImage.init()]
        XCTAssertFalse(view.invokedMakeCircularImage)
        XCTAssertFalse(view.invokedSetProfileImage)
        XCTAssertFalse(router.invokedDismissPickerController)
        XCTAssertEqual(view.invokedMakeCircularImageCount, .zero)
        XCTAssertEqual(view.invokedSetProfileImageCount, .zero)
        XCTAssertEqual(router.invokedDismissPickerControllerCount, .zero)
        XCTAssertNil(sut.profileImage)
        
        sut.didImageSelected(info)
        
        XCTAssertTrue(view.invokedMakeCircularImage)
        XCTAssertTrue(view.invokedSetProfileImage)
        XCTAssertTrue(router.invokedDismissPickerController)
        XCTAssertEqual(view.invokedMakeCircularImageCount, 1)
        XCTAssertEqual(view.invokedSetProfileImageCount, 1)
        XCTAssertEqual(router.invokedDismissPickerControllerCount, 1)
        XCTAssertNotNil(sut.profileImage)
    }
    func test_didImageSelected_WithNilSelectedUIImageIsGiven_DoNotInvokeMethods() {
        let info: [UIImagePickerController.InfoKey: Any] = [.editedImage: UIImage?.self]
        XCTAssertFalse(view.invokedMakeCircularImage)
        XCTAssertFalse(view.invokedSetProfileImage)
        XCTAssertFalse(router.invokedDismissPickerController)
        XCTAssertEqual(view.invokedMakeCircularImageCount, .zero)
        XCTAssertEqual(view.invokedSetProfileImageCount, .zero)
        XCTAssertEqual(router.invokedDismissPickerControllerCount, .zero)
        XCTAssertNil(sut.profileImage)

        sut.didImageSelected(info)
        
        XCTAssertFalse(view.invokedMakeCircularImage)
        XCTAssertFalse(view.invokedSetProfileImage)
        XCTAssertFalse(router.invokedDismissPickerController)
        XCTAssertEqual(view.invokedMakeCircularImageCount, .zero)
        XCTAssertEqual(view.invokedSetProfileImageCount, .zero)
        XCTAssertEqual(router.invokedDismissPickerControllerCount, .zero)
        XCTAssertNil(sut.profileImage)
    }
    func test_showPicker_InvokeRequiredMethods() {
        XCTAssertFalse(router.invokedShowPickerController)
        XCTAssertEqual(router.invokedShowPickerControllerCount, .zero)
        
        sut.showPicker()
        
        XCTAssertTrue(router.invokedShowPickerController)
        XCTAssertEqual(router.invokedShowPickerControllerCount, 1)
    }
    func test_registerValidatedUser_WithAuthCredentials_InvokeRequestedMethods() {
        XCTAssertFalse(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, .zero)
        
        sut.registerValidatedUser(withAuthCredentials: .init(email: "", password: "", username: "", profileImage: .init()))
        
        XCTAssertTrue(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, 1)
    }
    func test_handleError_WithError_InvokeRequestedParameters() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleError(error)
                       
        XCTAssertTrue(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertTrue(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    func test_validateUserInputs_WithNilParameters_InvokeDesiredMethods() {
        XCTAssertFalse(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, .zero)
        XCTAssertFalse(signUpValidator.invokedSignUpModelSetter)
        XCTAssertEqual(signUpValidator.invokedSignUpModelSetterCount, .zero)
        XCTAssertFalse(signUpValidator.invokedValidateAll)
        XCTAssertEqual(signUpValidator.invokedValidateAllCount, .zero)
        XCTAssertFalse(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, .zero)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.validateUserInputs(email: nil, password: nil, username: nil)
        
        XCTAssertTrue(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, 1)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.backgroundColor, "blurBackground2")
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.named, .userLoading)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.mode, .loop)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.speed, 2)
        XCTAssertNil(view.invokedConfigureAnimationNamedParameters?.completion)
        XCTAssertFalse(signUpValidator.invokedSignUpModelSetter)
        XCTAssertEqual(signUpValidator.invokedSignUpModelSetterCount, .zero)
        XCTAssertFalse(signUpValidator.invokedValidateAll)
        XCTAssertEqual(signUpValidator.invokedValidateAllCount, .zero)
        XCTAssertFalse(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, .zero)
        XCTAssertTrue(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
        XCTAssertTrue(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, "One of the field is nil")
    }
    func test_validateUserInputs_WithGivenPassedParameters_InvokeDesiredMethods() {
        sut.didImageSelected([.editedImage: UIImage.init()])
        XCTAssertFalse(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, .zero)
        XCTAssertFalse(signUpValidator.invokedSignUpModelSetter)
        XCTAssertEqual(signUpValidator.invokedSignUpModelSetterCount, .zero)
        XCTAssertFalse(signUpValidator.invokedValidateAll)
        XCTAssertEqual(signUpValidator.invokedValidateAllCount, .zero)
        XCTAssertFalse(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, .zero)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.validateUserInputs(email: "", password: "", username: "")
        
        XCTAssertTrue(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, 1)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.speed, 2)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.named, .userLoading)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.mode, .loop)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.backgroundColor, "blurBackground2")
        XCTAssertNil(view.invokedConfigureAnimationNamedParameters?.completion)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertTrue(signUpValidator.invokedValidateAll)
        XCTAssertTrue(signUpValidator.invokedSignUpModelSetter)
        XCTAssertNotNil(signUpValidator.invokedSignUpModel)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertTrue(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, 1)
    }
    func test_validateUserInputs_WithNotValidatedInputs_InvokeRequiredMethods() {
        signUpValidator.stubbedValidateAllError = SignUpErrors.emailTooShort
        sut.didImageSelected([.editedImage: UIImage.init()])
        XCTAssertFalse(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, .zero)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertFalse(signUpValidator.invokedValidateAll)
        XCTAssertFalse(signUpValidator.invokedSignUpModelSetter)
        XCTAssertEqual(signUpValidator.invokedSignUpModelSetterCount, .zero)
        XCTAssertFalse(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, .zero)

        sut.validateUserInputs(email: "", password: "", username: "")
        
        XCTAssertTrue(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, 1)
        XCTAssertTrue(signUpValidator.invokedValidateAll)
        XCTAssertEqual(signUpValidator.invokedSignUpModelSetterCount, 1)
        XCTAssertFalse(interactor.invokedRegisterUser)
        XCTAssertEqual(interactor.invokedRegisterUserCount, .zero)
        XCTAssertTrue(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, 1)
    }
    // MARK: -
    func test_handleRegistration_WithSuccessResult_InvokeRequiredMethdods() {
        view.stubbedLottieCompletionBlock = (true, ())
        
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertFalse(view.invokedConfigureAnimationNamed)
        XCTAssertFalse(router.invokedPopNavToLogin)
        XCTAssertEqual(router.invokedPopNavToLoginCount, .zero)
        
        sut.handleRegistration(result: .success(()))
        
        XCTAssertNotNil(view.invokedConfigureAnimationNamedParameters?.completion)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.named, .registrationSuccess)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.mode, .playOnce)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.speed, 1.5)
        XCTAssertEqual(view.invokedConfigureAnimationNamedParameters?.backgroundColor, "blurBackground2")
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        XCTAssertTrue(view.invokedRemoveAnimation)
        XCTAssertTrue(router.invokedPopNavToLogin)
        XCTAssertEqual(router.invokedPopNavToLoginCount, 1)
    }
    func test_handleRegistration_WithFailureResult_InvokeRequiredMethods() {
        let error = NSError(domain: "", code: .zero)
        XCTAssertFalse(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, .zero)
        XCTAssertFalse(view.invokedRemoveAnimation)
        XCTAssertEqual(view.invokedRemoveAnimationCount, .zero)
        XCTAssertFalse(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, .zero)
        
        sut.handleRegistration(result: .failure(error))
        
        XCTAssertFalse(view.invokedConfigureAnimationNamed)
        XCTAssertEqual(view.invokedConfigureAnimationNamedCount, .zero)
        XCTAssertNil(view.invokedConfigureAnimationNamedParameters)
        XCTAssertFalse(router.invokedPopNavToLogin)
        XCTAssertEqual(router.invokedPopNavToLoginCount, .zero)
        XCTAssertTrue(router.invokedShowAlert)
        XCTAssertEqual(router.invokedShowAlertCount, 1)
        XCTAssertEqual(router.invokedShowAlertParameters?.message, error.localizedDescription)
    }
    func test_changeOriginYPointOfView_WithParameters_InvokeRequiredMethods() {
        XCTAssertFalse(view.invokedHideNavigationItemBackButtonItem)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemCount, .zero)
        XCTAssertFalse(view.invokedSetOriginYPointOfTheView)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewCount, .zero)
        
        sut.changeOriginYPointOfView(with: 10, hideBackButton: true, animated: true)
        
        XCTAssertTrue(view.invokedHideNavigationItemBackButtonItem)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemCount, 1)
        XCTAssertTrue(view.invokedSetOriginYPointOfTheView)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewCount, 1)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemParameters?.hide, true)
        XCTAssertEqual(view.invokedHideNavigationItemBackButtonItemParameters?.animated, true)
        XCTAssertEqual(view.invokedSetOriginYPointOfTheViewParameters?.yPoint, 10)
    }
    func test_moveBackToDefaultYPoint_WithParameters_InvokeRequiredMethods() {
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
    func test_popToLogin_ShowLoginScreen() {
        XCTAssertFalse(router.invokedPopNavToLogin)
        XCTAssertEqual(router.invokedPopNavToLoginCount, .zero)
        
        sut.popToLogin()
        
        XCTAssertTrue(router.invokedPopNavToLogin)
        XCTAssertEqual(router.invokedPopNavToLoginCount, 1)
    }
}
