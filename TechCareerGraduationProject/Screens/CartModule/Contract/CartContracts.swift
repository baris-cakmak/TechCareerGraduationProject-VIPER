//
//  CartContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import Foundation
import UIKit

protocol ViewToPresenterCartProtocol {
    var view: PresenterToViewCartProtocol? { get set }
    var interactor: PresenterToInteractorCartProtocol? { get set }
    var router: PresenterToRouterCartProtocol? { get set }
    
    func updateLeftLabelByStepperValue(_ stepperValue: Double) -> String
    func calculateMealPriceByStepper(stepperValue: Double, indexPath: IndexPath?)
    func calculateTotalPrice() -> String
    func getMealsAtTheCart()
    func viewWillAppear()
    func numberOfRowsInSection() -> Int
    func cartViewModel(at indexPath: IndexPath) -> CartViewModel
    func deleteMealFromTheCart(at indexPath: IndexPath?)
    func deleteAllItemsAtTheCart()
    func handleStepperValue(_ stepperValue: Double, at indexPath: IndexPath)
    func orderMealsAtTheCart()
    func didTapDeleteAll()
    
}

protocol PresenterToInteractorCartProtocol {
    var presenter: InteractorToPresenterCartProtocol? { get set }
    func fetchMealsAtTheCart()
    func deleteSingleMeal(of mealDeleteRequestModel: MealDeleteRequestModel, at indexPath: IndexPath)
    func deleteAllMeals(of mealDeleteRequestModel: MealDeleteRequestModel)
}

protocol PresenterToRouterCartProtocol {
    var presenter: RouterToPresenterCartProtocol? { get set }
    static func createModule() -> UINavigationController
    func showFirstTabToAddMeal()
    func showOrderDecisionPopUp()
    func showDeleteDecisionPopUp()
}

protocol InteractorToPresenterCartProtocol: AnyObject {
    func didErrorOccured(error: Error)
    func didFetchMealsAtTheCartSuccessfully(_ mealCartReponse: MealCartResponseModel)
    func didDeleteSuccessfully(at indexPath: IndexPath)
    func didAllDeleteRequestsFinished()
    
}

protocol PresenterToViewCartProtocol: AnyObject {
    func showLoadingAnimation(with animation: Animations)
    func removeLoadingAnimation()
    func reloadData()
    func reloadItems(at indexPath: IndexPath)
    func deleteItems(at indexPath: IndexPath)
    func updateCheckoutFooterPrice()

}

protocol RouterToPresenterCartProtocol: AnyObject {
    func didUserDecidedToGetTheOrder()
    func didDeleteAllReqeusted()
}

