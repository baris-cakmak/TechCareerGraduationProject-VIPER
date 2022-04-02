//
//  OnboardingManagerImp.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 2.04.2022.
//

import Foundation

protocol OnboardingManagerable {
    func getOnboardingSeen() -> Bool
    func setOnboardingSeen()
    func resetOnboardingSeen()
}
