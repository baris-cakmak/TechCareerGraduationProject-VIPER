//
//  OnboardingInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 2.04.2022.
//

import Foundation

class OnboardingInteractor: PresenterToInteractorOnboardingProtocol {
    
    weak var presenter: InteractorToPresenterOnboardingProtocol?
    
    var onboardingStorageManager: OnboardingManagerable?
    
    init(onboardingStorageManager: OnboardingManagerable?) {
        self.onboardingStorageManager = onboardingStorageManager
    }
    // MARK: - Method
    func setOnboardingSeen() {
        onboardingStorageManager?.setOnboardingSeen()
        presenter?.didOnboardingStateSaved()
    }
    
    
}
