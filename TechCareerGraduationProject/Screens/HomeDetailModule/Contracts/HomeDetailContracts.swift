//
//  HomeDetailContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit

protocol ViewToPresenterHomeDetailProtocol {
    var view: PresenterToViewHomeDetailProtocol? { get set }
    var interactor: PresenterToInteractorHomeDetailProtocol? { get set }
    var router: PresenterToRouterHomeDetailProtocol? { get set }
    var mealViewModel: MealViewModel? { get set }
    
    func viewDidLoad()
    func calculatePrice(by stepperValue: Double)
    func addMealsToCartInApi(orderCount: Double)
}

protocol PresenterToInteractorHomeDetailProtocol {
    var requestModel: MealAddToCartRequestModel? { get set }
    var mealSuccessResponseModel: MealSuccessResponseModel? { get set }
    var mealsAtTheCartResponseModel: MealCartResponseModel? { get set }
    var presenter: InteractorToPresenterHomeDetailProtocol? { get set }
    
    func addMealsToCart()
}

protocol PresenterToRouterHomeDetailProtocol {

    static func createModule(using navigationController: UINavigationController, mealViewModel: MealViewModel) -> UIViewController
    func popToHomeView()
    func showAlert(message: String)
}

protocol PresenterToViewHomeDetailProtocol: AnyObject {
    func configureInitialView(viewModel: MealViewModel)
    func didPriceChanged(price: String)
}
protocol InteractorToPresenterHomeDetailProtocol: AnyObject {
    func didMealAddedToCart()
    func didErrorOccured(error: Error)

}

