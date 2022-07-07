//
//  OnboardingCellPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 27.05.2022.
//

import XCTest
@testable import OnboardingModule
@testable import CommonKit

final class OnboardingCellPresenterTests: XCTestCase {
    var sut: OnboardingCellPresenter!
    var view: MockOnboardingCell!
    var delegate: MockOnboardingCellDelegate!
    
    private func createSutOf(viewModel: OnboardingViewModel) {
        sut = .init(view: view, onboardingViewModel: .init(animationName: viewModel.animationName, buttonBackgroundColor: viewModel.buttonBackgroundColor, descriptionText: viewModel.descriptionText, buttonText: viewModel.buttonText), delegate: delegate)
    }
    override func setUp() {
        view = .init()
        delegate = .init()
        sut = .init(view: view, onboardingViewModel: .init(animationName: nil, buttonBackgroundColor: nil, descriptionText: nil, buttonText: nil), delegate: delegate)
    }
    
    func testOnboardingCellPresenter_ConfigureNextButtonWithItsConstants_ReturnTrue() {
        XCTAssertFalse(view.isButtonAppearanceConfigured)
        
        sut.loadCell()
        
        XCTAssertTrue(view.isButtonAppearanceConfigured)
    }
    
    func testOnboardingCellPresenter_WhenUserTappedToNextButton_CallDesiredParameters() {
        XCTAssertFalse(delegate.didUserTapped)
        XCTAssertEqual(delegate.userTappedToNextButtonCount, 0)
        
        sut.didTapNextButton(view)
        
        XCTAssertTrue(delegate.didUserTapped)
        XCTAssertEqual(delegate.userTappedToNextButtonCount, 1)
    }

    func testOnboardingCellPresenter_MakeAnimationAsConfiguredParameters_ReturnDesiredParametersAsExpected() {
        createSutOf(viewModel: .init(animationName: Animations.onboardingOne, buttonBackgroundColor: nil, descriptionText: nil, buttonText: nil))
        XCTAssertNil(view.animationContentMode)
        XCTAssertNil(view.animationLoopMode)
        XCTAssertFalse(view.isOnboardingAnimationCalled)
        XCTAssertNil(view.animationName)
        
        sut.loadCell()
        
        XCTAssertTrue(view.isOnboardingAnimationCalled)
        XCTAssertEqual(view.animationLoopMode, .loop)
        XCTAssertEqual(view.animationContentMode, .scaleAspectFill)
        XCTAssertNotNil(view.animationName)
        XCTAssertEqual(view.animationName, sut.onboardingViewModel.animationName?.rawValue)
    }
    func testOnboardingCellPresenter_SetDescriptionLabelAttributes_ReturnDesiredParametersToBeAssigned() {
        createSutOf(viewModel: .init(animationName: nil, buttonBackgroundColor: nil, descriptionText: "testDescription", buttonText: nil))
        XCTAssertNil(view.descriptionLabelText)
        XCTAssertFalse(view.isConfigureDescriptionLabelCalled)
        
        sut.loadCell()
        
        XCTAssertTrue(view.isConfigureDescriptionLabelCalled)
        XCTAssertNotNil(view.descriptionLabelText)
        XCTAssertEqual(view.descriptionLabelText, sut.onboardingViewModel.descriptionText)
    }
    
    func testOnboardingCellPresenter_SetNextButtonAttributes_ReturnDesiredParametersAsExpected() {
        createSutOf(viewModel: .init(animationName: nil, buttonBackgroundColor: OnboardingModuleAsset.onboardingButtonBackgroundOne.name, descriptionText: nil, buttonText: "textToBeGivenAsExpected"))
        XCTAssertNil(view.backgroundColorOfNextButton)
        XCTAssertNil(view.titleOfNextButton)
        XCTAssertFalse(view.isConfigureNextButtonAttributesCalled)
        
        sut.loadCell()
        
        XCTAssertNotNil(view.backgroundColorOfNextButton)
        XCTAssertTrue(view.isConfigureNextButtonAttributesCalled)
        XCTAssertNotNil(view.titleOfNextButton)
        XCTAssertEqual(view.backgroundColorOfNextButton, .init(asset: OnboardingModuleAsset.onboardingButtonBackgroundOne))
        XCTAssertEqual(view.titleOfNextButton, sut.onboardingViewModel.buttonText)
    }
    
    override func tearDown() {
        view = nil
        delegate = nil
        sut = nil
    }
}
