//
//  HomeDetailRouter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit
import CommonKit
import HomeDetailModuleInterface
import DependencyManagerKit
import UserStorageManagerKit

protocol HomeDetailRouterInterface: AlertPresentable {
    func popToHomeView()
    func showAlert(message: String)
}

public final class HomeDetailRouter: HomeDetailModuleInterface {
    public func createModule(using navigationController: UINavigationController?, homeDetailViewModel: MealViewModel) -> UIViewController {
        @Dependency var userStorageManager: UserStorageManagerable
        let view = HomeDetailViewController.instantiate(with: .homeDetail, bundle: .module)
        let interactor = HomeDetailInteractor()
        let router = HomeDetailRouter(navigationController: navigationController)
        let presenter = HomeDetailPresenter(
            view: view,
            interactor: interactor,
            router: router,
            homeDetailViewModel: homeDetailViewModel,
            userStorageManager: userStorageManager
        )
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    public private(set) weak var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
// MARK: - Method
extension HomeDetailRouter: HomeDetailRouterInterface {
    func popToHomeView() {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - Alert Presentable
extension HomeDetailRouter: AlertPresentable {
}
