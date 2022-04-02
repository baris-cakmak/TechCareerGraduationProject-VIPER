//
//  OnboardingContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import UIKit

protocol ViewToPresenterOnboardingProtocol {
    var view: PresenterToViewOnboardingProtocol? { get set }
    var interactor: PresenterToInteractorOnboardingProtocol? { get set }
    var router: PresenterToRouterOnboardingProtocol? { get set }
    func didUserTappedNextButton(at indexPath: IndexPath?)
    func configureViewModels()
    func numberOfRowsInSection() -> Int
    func getViewModel(at indexPath: IndexPath) -> OnboardingViewModel}


protocol PresenterToRouterOnboardingProtocol {
    static func createModule() -> UIViewController
    func setRootViewControllerAsLogin()
}

protocol PresenterToInteractorOnboardingProtocol {
    var presenter: InteractorToPresenterOnboardingProtocol? { get set }
    var onboardingStorageManager:OnboardingManagerable? { get set }
    func setOnboardingSeen()
}

protocol InteractorToPresenterOnboardingProtocol: AnyObject {
    func didOnboardingStateSaved()
}

protocol PresenterToViewOnboardingProtocol: AnyObject {
    func reloadData()
    func scrollToNextItem(at indexPath: IndexPath)
}
