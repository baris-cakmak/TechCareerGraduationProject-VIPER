//
//  OnboardingManager.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 2.04.2022.
//

import Foundation

enum OnboardingKey: String {
    case onboarding
}


class OnboardingStorageManager: OnboardingManagerable {
    
    // MARK: - Get Onboarding Seen value from UserDefaults
    func getOnboardingSeen() -> Bool {
        return UserDefaults.standard.bool(forKey: OnboardingKey.onboarding.rawValue)
    }
    // MARK: - Set UserDefault value as True
    func setOnboardingSeen() {
        UserDefaults.standard.set(true, forKey: OnboardingKey.onboarding.rawValue)
    }
    
    // MARK: - Reset Onboarding Seen for manual test case
    func resetOnboardingSeen() {
        UserDefaults.standard.set(false, forKey: OnboardingKey.onboarding.rawValue)
    }
}
