//
//  MainTabBarContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import UIKit

protocol ViewToPresenterMainTabBarProtocol {
    var view: PresenterToViewMainTabBarProtocol? { get set }
    var interactor: PresenterToInteractorMainTabBarProtocol? { get set }
    var router: PresenterToRouterMainTabBarProtocol? { get set }
    var mealViewModel: MealViewModel? { get set }
    
    func viewWillAppear()
    func getItemsAtTheCart()
}

protocol PresenterToInteractorMainTabBarProtocol {
    var mealsAtTheCartResponseModel: MealCartResponseModel? { get set }
    var presenter: InteractorToPresenterMainTabBarProtocol? { get set }
    
    func getMealsAtTheCart()

}

protocol PresenterToRouterMainTabBarProtocol {

    static func createModule() -> UIViewController
}

protocol PresenterToViewMainTabBarProtocol: AnyObject {
    func updateBadgeValueOfCartTabBar(_ value: String?)
}
protocol InteractorToPresenterMainTabBarProtocol: AnyObject {
    func didMealsAtTheCartFetchedSuccessfully(_ response: MealCartResponseModel)
    func didErrorOccured(error: Error)

}

