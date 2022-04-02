//
//  HomeDetailContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import Foundation
import UIKit

protocol ViewToPresenterHomeDetailProtocol {
    var view: PresenterToViewHomeDetailProtocol? { get set }
    var interactor: PresenterToInteractorHomeDetailProtocol? { get set }
    var router: PresenterToRouterHomeDetailProtocol? { get set }
    var mealViewModel: MealViewModel? { get set }
    
    func viewDidLoad()
    func calculatePrice(by stepperValue: Double)
    func addMealsToCartInApi(orderCount: Double)
    func getItemsAtTheCart()
}

protocol PresenterToInteractorHomeDetailProtocol {
    var requestModel: MealAddToCartRequestModel? { get set }
    var mealSuccessResponseModel: MealSuccessResponseModel? { get set }
    var mealsAtTheCartResponseModel: MealCartResponseModel? { get set }
    var presenter: InteractorToPresenterHomeDetailProtocol? { get set }
    
    func addMealsToCart()
    func getMealsAtTheCart()
}

protocol PresenterToRouterHomeDetailProtocol {

    static func createModule(using navigationController: UINavigationController, mealViewModel: MealViewModel) -> UIViewController
    func popToHomeView()
    func showAlert(message: String)
}

protocol PresenterToViewHomeDetailProtocol: AnyObject {
    func configureInitialView(viewModel: MealViewModel)
    func didPriceChanged(price: String)
    func updateBadgeValueOfCartTabBar(_ value: String?)
}
protocol InteractorToPresenterHomeDetailProtocol: AnyObject {
    func didMealAddedToCart()
    func didErrorOccured(error: Error)
    func didMealsAtTheCartFetchedSuccessfully(_ response: MealCartResponseModel)
}
