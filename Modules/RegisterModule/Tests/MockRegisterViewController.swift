//
//  MockRegisterViewController.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 25.05.2022.
//

import UIKit
import Lottie
@testable import RegisterModule
@testable import CommonKit
@testable import LottieAnimationConfigurableKit

final class MockRegisterViewController: RegisterPresenterOutputInterface, BackButtonHiddenable, KeyboardNotificationConfigurable, LottieAnimationConfigurable, TapDismissable, ViewFrameChangable {

    var invokedAnimationViewGetter = false
    var invokedAnimationViewGetterCount = 0
    var stubbedAnimationView: AnimationView!

    var animationView: AnimationView? {
        invokedAnimationViewGetter = true
        invokedAnimationViewGetterCount += 1
        return stubbedAnimationView
    }

    var invokedTapGestureSetter = false
    var invokedTapGestureSetterCount = 0
    var invokedTapGesture: UITapGestureRecognizer?
    var invokedTapGestureList = [UITapGestureRecognizer?]()
    var invokedTapGestureGetter = false
    var invokedTapGestureGetterCount = 0
    var stubbedTapGesture: UITapGestureRecognizer!

    var tapGesture: UITapGestureRecognizer? {
        set {
            invokedTapGestureSetter = true
            invokedTapGestureSetterCount += 1
            invokedTapGesture = newValue
            invokedTapGestureList.append(newValue)
        }
        get {
            invokedTapGestureGetter = true
            invokedTapGestureGetterCount += 1
            return stubbedTapGesture
        }
    }

    var invokedConfigureSignInContainer = false
    var invokedConfigureSignInContainerCount = 0

    func configureSignInContainer() {
        invokedConfigureSignInContainer = true
        invokedConfigureSignInContainerCount += 1
    }

    var invokedSetupTextFieldDelegates = false
    var invokedSetupTextFieldDelegatesCount = 0

    func setupTextFieldDelegates() {
        invokedSetupTextFieldDelegates = true
        invokedSetupTextFieldDelegatesCount += 1
    }

    var invokedMakeCircularImage = false
    var invokedMakeCircularImageCount = 0

    func makeCircularImage() {
        invokedMakeCircularImage = true
        invokedMakeCircularImageCount += 1
    }

    var invokedSetProfileImage = false
    var invokedSetProfileImageCount = 0
    var invokedSetProfileImageParameters: (image: UIImage, Void)?
    var invokedSetProfileImageParametersList = [(image: UIImage, Void)]()

    func setProfileImage(_ image: UIImage) {
        invokedSetProfileImage = true
        invokedSetProfileImageCount += 1
        invokedSetProfileImageParameters = (image, ())
        invokedSetProfileImageParametersList.append((image, ()))
    }

    var invokedConfigureAnimationNamed = false
    var invokedConfigureAnimationNamedCount = 0
    var invokedConfigureAnimationNamedParameters: (named: Animations, mode: LottieLoopMode, speed: CGFloat, backgroundColor: String, completion: LottieCompletionBlock?)?
    var invokedConfigureAnimationNamedParametersList = [(named: Animations, mode: LottieLoopMode, speed: CGFloat, backgroundColor: String, completion: LottieCompletionBlock?)]()
    var stubbedLottieCompletionBlock: (Bool, Void)?
    func configureAnimation(named: Animations, mode: LottieLoopMode, speed: CGFloat, backgroundColor: String, completion: LottieCompletionBlock?) {
        invokedConfigureAnimationNamed = true
        invokedConfigureAnimationNamedCount += 1
        invokedConfigureAnimationNamedParameters = (named, mode, speed, backgroundColor, completion)
        invokedConfigureAnimationNamedParametersList.append((named, mode, speed, backgroundColor, completion))
        if let result = stubbedLottieCompletionBlock {
            completion?(result.0)
        }
    }

    var invokedHideNavigationItemBackButtonItem = false
    var invokedHideNavigationItemBackButtonItemCount = 0
    var invokedHideNavigationItemBackButtonItemParameters: (hide: Bool, animated: Bool)?
    var invokedHideNavigationItemBackButtonItemParametersList = [(hide: Bool, animated: Bool)]()

    func hideNavigationItemBackButtonItem(_ hide: Bool, animated: Bool) {
        invokedHideNavigationItemBackButtonItem = true
        invokedHideNavigationItemBackButtonItemCount += 1
        invokedHideNavigationItemBackButtonItemParameters = (hide, animated)
        invokedHideNavigationItemBackButtonItemParametersList.append((hide, animated))
    }

    var invokedConfigureKeyboardNotifications = false
    var invokedConfigureKeyboardNotificationsCount = 0

    func configureKeyboardNotifications() {
        invokedConfigureKeyboardNotifications = true
        invokedConfigureKeyboardNotificationsCount += 1
    }

    var invokedConfigureAnimation = false
    var invokedConfigureAnimationCount = 0

    func configureAnimation() {
        invokedConfigureAnimation = true
        invokedConfigureAnimationCount += 1
    }

    var invokedRemoveAnimation = false
    var invokedRemoveAnimationCount = 0

    func removeAnimation() {
        invokedRemoveAnimation = true
        invokedRemoveAnimationCount += 1
    }

    var invokedConfigureTapGesture = false
    var invokedConfigureTapGestureCount = 0

    func configureTapGesture() {
        invokedConfigureTapGesture = true
        invokedConfigureTapGestureCount += 1
    }

    var invokedSetOriginYPointOfTheView = false
    var invokedSetOriginYPointOfTheViewCount = 0
    var invokedSetOriginYPointOfTheViewParameters: (yPoint: Float, Void)?
    var invokedSetOriginYPointOfTheViewParametersList = [(yPoint: Float, Void)]()

    func setOriginYPointOfTheView(with yPoint: Float) {
        invokedSetOriginYPointOfTheView = true
        invokedSetOriginYPointOfTheViewCount += 1
        invokedSetOriginYPointOfTheViewParameters = (yPoint, ())
        invokedSetOriginYPointOfTheViewParametersList.append((yPoint, ()))
    }
}
