//
//  OnboardingPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import Foundation
import UIKit.UIColor

class OnboardingPresenter: ViewToPresenterOnboardingProtocol {

    weak var view: PresenterToViewOnboardingProtocol?
    var interactor: PresenterToInteractorOnboardingProtocol?
    
    var router: PresenterToRouterOnboardingProtocol?
    
    var viewModels: [OnboardingViewModel]?
    
    // MARK: - Method
    
    func configureViewModels() {
        viewModels = [
            OnboardingViewModel(animationName: .onboardingOne, buttonBackgroundColor: UIColor(named: "onboardingButtonBackgroundOne")!, descriptionText: "Add your favourite food to enjoy!!", buttonText: "I am Hungryyy"),
            OnboardingViewModel(animationName: .onboardingTwo,
                                buttonBackgroundColor: UIColor(named: "onboardingButtonBackgroundTwo")!,
                                descriptionText: "Notify when the food is prepared by the Restaurant!", buttonText: "Big Brother is Watching You"),
            OnboardingViewModel(animationName: .onboardingThree, buttonBackgroundColor: UIColor(named: "onboardingButtonBackgroundThree")!, descriptionText: "Fastest delivery in your hometown!!", buttonText: "LET ME IN!")
        ]
        view?.reloadData()
    }
    func numberOfRowsInSection() -> Int {
        guard let viewModels = viewModels else {
            return 0
        }
        return viewModels.count

    }
    
    func getViewModel(at indexPath: IndexPath) -> OnboardingViewModel {
        return viewModels![indexPath.item]
    }
    
    func didUserTappedNextButton(at indexPath: IndexPath?) {
        guard let indexPath = indexPath, let viewModels = viewModels else { return }
        
        if indexPath.item == viewModels.count - 1 {
            interactor?.setOnboardingSeen()
        } else {
            let nextIndexPath = IndexPath(item: indexPath.item + 1, section: 0)
            view?.scrollToNextItem(at: nextIndexPath)
        }
    }
    
}
extension OnboardingPresenter: InteractorToPresenterOnboardingProtocol {
    
    func didOnboardingStateSaved() {
        router?.setRootViewControllerAsLogin()
    }
    
    
}
