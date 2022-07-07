//
//  RegisterModuleInterface.swift
//  RegisterModuleInterface
//
//  Created by Peace on 30.06.2022.
//

import UIKit

public protocol RegisterModuleInterface {
    func createModule(using navigationController: UINavigationController) -> UIViewController
}
