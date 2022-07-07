//
//  OnboardingPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import Foundation
import UIKit.UIColor

protocol OnboardingPresenterInterface {
    func viewDidLoad()
    func didUserTappedNextButton(at indexPath: IndexPath?)
    func configureViewModels()
    func numberOfItemsInSection() -> Int
    func getViewModel(at indexPath: IndexPath) -> OnboardingViewModel
}

final class OnboardingPresenter: OnboardingPresenterInterface {
    weak private var view: OnboardingPresenterOutputInterface?
    private let interactor: OnboardingInteractorInterface?
    private let router: OnboardingRouterInterface?
    
    init(
        view: OnboardingPresenterOutputInterface?,
        interactor: OnboardingInteractorInterface?,
        router: OnboardingRouterInterface?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    private var viewModels: [OnboardingViewModel] = []
}
// MARK: - View To Presenter
extension OnboardingPresenter {
    func viewDidLoad() {
        configureViewModels()
        view?.configureOnboardingCollectionView()
        view?.configurePageControl()
    }
    func configureViewModels() {
        viewModels = [
            OnboardingViewModel(
                animationName: .onboardingOne,
                buttonBackgroundColor: "onboardingButtonBackgroundOne",
                descriptionText: "Add your favourite food to enjoy!!",
                buttonText: "I am Hungryyy"
            ),
            OnboardingViewModel(
                animationName: .onboardingTwo,
                buttonBackgroundColor: "onboardingButtonBackgroundTwo",
                descriptionText: "Notify when the food is prepared by the Restaurant!",
                buttonText: "Big Brother is Watching You"
            ),
            OnboardingViewModel(
                animationName: .onboardingThree,
                buttonBackgroundColor: "onboardingButtonBackgroundThree",
                descriptionText: "Fastest delivery in your hometown!!",
                buttonText: "LET ME IN!"
            )
        ]
        view?.reloadData()
    }
    func numberOfItemsInSection() -> Int {
        viewModels.count
    }
    
    func getViewModel(at indexPath: IndexPath) -> OnboardingViewModel {
        viewModels[indexPath.item]
    }
    
    func didUserTappedNextButton(at indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        
        if indexPath.item == viewModels.count - 1 {
            interactor?.setOnboardingSeen()
        } else {
            let nextIndexPath = IndexPath(item: indexPath.item + 1, section: 0)
            view?.scrollToNextItem(at: nextIndexPath)
        }
    }
}

// MARK: - Interactor To Presenter
protocol OnboardingInteractorOutputInterface: AnyObject {
    func didOnboardingStateSaved()
}
extension OnboardingPresenter: OnboardingInteractorOutputInterface {
    func didOnboardingStateSaved() {
        router?.setRootViewControllerAsLogin()
    }
}
