//
//  RootRouterInterface.swift
//  RootModuleInterface
//
//  Created by Peace on 27.06.2022.
//

import UIKit

public protocol RootModuleInterface {
    func createModule(using navigationController: UINavigationController?) -> UIViewController
}
