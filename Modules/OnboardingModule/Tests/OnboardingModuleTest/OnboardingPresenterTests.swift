//
//  OnboardingPresenterTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import XCTest
@testable import OnboardingModule

final class OnboardingPresenterTests: XCTestCase {
    var view: MockOnboardingViewController!
    var interactor: MockOnboardingInteractor!
    var router: MockOnboardingRouter!
    var sut: OnboardingPresenter!
    
    override func setUp() {
        view = MockOnboardingViewController()
        interactor = MockOnboardingInteractor()
        router = MockOnboardingRouter()
        sut = .init(view: view, interactor: interactor, router: router)
    }
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
    }
    func test_viewDidLoad_InvokeRequiredMethods() {
        XCTAssertEqual(view.invokedReloadDataCount, .zero)
        XCTAssertEqual(view.invokedConfigureOnboardingCollectionViewCount, .zero)
        XCTAssertEqual(view.invokedConfigurePageControlCount, .zero)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(view.invokedConfigureOnboardingCollectionViewCount, 1)
        XCTAssertEqual(view.invokedConfigurePageControlCount, 1)
    }
    func test_numberOfıtemsInSection_ReturnItemCountAsExpected() {
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.numberOfItemsInSection(), 3)
    }
    func test_getViewModel_AtIndexPath() {
        sut.viewDidLoad()
        
        let viewModel = sut.getViewModel(at: .init(item: .zero, section: .zero))
        
        XCTAssertEqual(viewModel.animationName, .onboardingOne)
        XCTAssertEqual(viewModel.buttonBackgroundColor, "onboardingButtonBackgroundOne")
        XCTAssertEqual(viewModel.descriptionText, "Add your favourite food to enjoy!!")
        XCTAssertEqual(viewModel.buttonText, "I am Hungryyy")
    }
    func test_didUserTappedNextButton_AtIndexPath_WithValidIndexPath_NotTheLastItem_InvokeRequiredMethods() {
        sut.viewDidLoad()
        XCTAssertEqual(interactor.invokedSetOnboardingSeenCount, .zero)
        XCTAssertEqual(view.invokedScrollToNextItemCount, .zero)
        
        sut.didUserTappedNextButton(at: .init(item: .zero, section: .zero))
        
        XCTAssertEqual(interactor.invokedSetOnboardingSeenCount, .zero)
        XCTAssertEqual(view.invokedScrollToNextItemCount, 1)
        XCTAssertEqual(view.invokedScrollToNextItemParameters?.indexPath, .init(item: 1, section: .zero))
    }
    func test_didUserTappedButton_AtValidIndexPath_WhichIsTheLastItem_InvokeRequiredMethods() {
        sut.viewDidLoad()
        let totalItemCount = sut.numberOfItemsInSection()
        XCTAssertEqual(view.invokedScrollToNextItemCount, .zero)
        XCTAssertEqual(interactor.invokedSetOnboardingSeenCount, .zero)
        
        sut.didUserTappedNextButton(at: .init(item: totalItemCount - 1, section: .zero))
        
        XCTAssertEqual(interactor.invokedSetOnboardingSeenCount, 1)
        XCTAssertEqual(view.invokedScrollToNextItemCount, .zero)
    }
    func test_didUserTappedNextButton_AtNilIndexPath_DoNotInvokeMethods() {
        XCTAssertEqual(interactor.invokedSetOnboardingSeenCount, .zero)
        XCTAssertEqual(view.invokedScrollToNextItemCount, .zero)
        
        sut.didUserTappedNextButton(at: nil)
        
        XCTAssertEqual(interactor.invokedSetOnboardingSeenCount, .zero)
        XCTAssertEqual(view.invokedScrollToNextItemCount, .zero)
    }
    func test_didOnboardingStateSaved_InvokeRequiredMethods() {
        XCTAssertEqual(router.invokedSetRootViewControllerAsLoginCount, .zero)
        
        sut.didOnboardingStateSaved()
        
        XCTAssertEqual(router.invokedSetRootViewControllerAsLoginCount, 1)
    }    
}
