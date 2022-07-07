//
//  HomeModuleInterface.swift
//  HomeModuleInterface
//
//  Created by Peace on 30.06.2022.
//

import UIKit

public protocol HomeModuleInterface {
    func createModule(using navigationController: UINavigationController?) -> UIViewController
}
