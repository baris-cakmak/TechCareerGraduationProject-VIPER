//
//  OnboardingInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 2.04.2022.
//

import Foundation
import OnboardingManagerKit
import DependencyManagerKit

protocol OnboardingInteractorInterface {
    func setOnboardingSeen()
}

final class OnboardingInteractor: OnboardingInteractorInterface {
    weak var presenter: OnboardingInteractorOutputInterface?
    
    @Dependency private var onboardingStorageManager: OnboardingManagerable
}
// MARK: - Method
extension OnboardingInteractor {
    func setOnboardingSeen() {
        onboardingStorageManager.setOnboardingSeen()
        presenter?.didOnboardingStateSaved()
    }
}
