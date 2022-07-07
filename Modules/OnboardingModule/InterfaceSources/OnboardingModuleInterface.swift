//
//  OnboardingModuleInterface.swift
//  OnboardingModuleInterface
//
//  Created by Peace on 28.06.2022.
//

import UIKit

public protocol OnboardingModuleInterface {
    func createModule(using navigationController: UINavigationController) -> UIViewController
}
