//
//  HomeDetailModuleInterface.swift
//  HomeDetailModule
//
//  Created by Peace on 30.06.2022.
//

import UIKit

public protocol HomeDetailModuleInterface {
    func createModule(using navigationController: UINavigationController?, homeDetailViewModel: MealViewModel) -> UIViewController
}
