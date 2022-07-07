//
//  MainTabBarRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import UIKit
import MainTabBarModuleInterface

protocol MainTabBarRouterInterface {
}

public final class MainTabBarRouter: MainTabBarModuleInterface {
    public init() {}
    
    public func createModule() -> UIViewController {
        let view = MainTabBarController()
        let interactor = MainTabBarIntereactor()
        let router = MainTabBarRouter()
        let presenter = MainTabBarPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Method
extension MainTabBarRouter: MainTabBarRouterInterface {
}
