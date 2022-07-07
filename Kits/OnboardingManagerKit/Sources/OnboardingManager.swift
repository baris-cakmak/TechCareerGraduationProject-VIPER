//
//  OnboardingManager.swift
//  OnboardingManagerKit
//
//  Created by Peace on 21.06.2022.
//
import Foundation

enum OnboardingKey: String {
    case onboarding
}

public protocol OnboardingManagerable {
    func getOnboardingSeen() -> Bool
    func setOnboardingSeen()
    func resetOnboardingSeen()
}

public final class OnboardingManager: OnboardingManagerable {
    public init() {}
    public func getOnboardingSeen() -> Bool {
        UserDefaults.standard.bool(forKey: OnboardingKey.onboarding.rawValue)
    }
    public func setOnboardingSeen() {
        UserDefaults.standard.set(true, forKey: OnboardingKey.onboarding.rawValue)
    }
    public func resetOnboardingSeen() {
        UserDefaults.standard.set(false, forKey: OnboardingKey.onboarding.rawValue)
    }
}
