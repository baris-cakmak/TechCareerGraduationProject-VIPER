//
//  HomeModuleContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit

protocol ViewToPresenterHomeProtocol {
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
    var mealViewModels: [MealViewModel]? { get set }
    
    func viewDidLoad()
    func numberOfRowInSection() -> Int
    func getViewModels()
    func getViewModel(at indexPath: IndexPath) -> MealViewModel
    func getMealsAtTheCart()
    func goToHomeDetail(with indexPath: IndexPath)
}
protocol PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol? { get set }
    var mealResponseModel: MealResponseModel? { get set }
    
    func getAllMeals()
    func fetchMealsAtTheCart()
}
protocol InteractorToPresenterHomeProtocol: AnyObject {
    func didFetchAllMealsSuccessfully(responseModel: MealResponseModel)
    func didFetchWithAnError(error: Error)
    func didFetchMealsAtTheCart(responseModel: MealCartResponseModel)
}
protocol PresenterToViewHomeProtocol: AnyObject {
    func showLoadingAnimation()
    func removeLoadingAnimation()
    func reloadData()
    func updateBadgeCountOfCartTabBar(badgeValue: String?)
}
protocol PresenterToRouterHomeProtocol {
    var navigationController: UINavigationController? { get set }
    static func createModule() -> UINavigationController
    func showHomeDetail(with meal: MealViewModel)
    func showErrorPopUp(message: String)
}
