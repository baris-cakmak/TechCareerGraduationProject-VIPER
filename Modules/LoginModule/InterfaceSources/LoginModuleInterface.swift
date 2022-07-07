//
//  LoginModuleInterface.swift
//  LoginModule
//
//  Created by Peace on 27.06.2022.
//

import UIKit

public protocol LoginModuleInterface {
    func createModule(using navigationController: UINavigationController) -> UIViewController
}
