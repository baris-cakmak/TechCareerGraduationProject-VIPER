//
//  RestaurantContracts.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//


import UIKit

protocol ViewToPresenterRestaurantProtocol {
    var view: PresenterToViewRestaurantProtocol? { get set }
    var interactor: PresenterToInteractorRestaurantProtocol? { get set }
    var router: PresenterToRouterRestaurantProtocol? { get set }
    var offerViewModels: [OfferViewModel]? { get set }
    var newRestaurantViewModels: [NewRestaurantViewModel]? { get set }
    var restaurantViewModels: [RestaurantViewModel]? { get set }
    func viewDidLoad()
    
    func numberOfRowInSectionOffer() -> Int
    func numberOfRowInSectionNewRestaurant() -> Int
    func numberOfRowsInSectionRestaurant() -> Int

    func getOfferViewModels()
    func getNewRestaurantViewModels()
    func getRestaurantViewModels()

    func getOfferViewModel(at indexPath: IndexPath) -> OfferViewModel
    func getNewRestaurantViewModel(at indexPath: IndexPath) -> NewRestaurantViewModel
    func getRestaurantViewModel(at indexPath: IndexPath) -> RestaurantViewModel
    func handleRestaurantStatus(_ status: RestaurantStatus) -> UIColor
    func goToHome()
}
protocol PresenterToInteractorRestaurantProtocol {
    var presenter: InteractorToPresenterRestaurantProtocol? { get set }
    var offerResponseModel: [RestaurantOfferResponseModel]? { get set }
    var newRestaurantResponseModel: [RestaurantNewRestaurantsResponseModel]? { get set}
    var restaurantResponseModel: [RestaurantResponseModel]? { get set }
    func fetchOffers()
    func fetchNewRestaurants()
    func fetchRestaurants()
}
protocol InteractorToPresenterRestaurantProtocol: AnyObject {
    func didFetchOffers(_ offerResponse: [RestaurantOfferResponseModel])
    func didFetchNewRestaurants(_ newRestaurantsResponse: [RestaurantNewRestaurantsResponseModel])
    func didFetchRestaurants(_ restaurantResponse: [RestaurantResponseModel])
    func didErrorOccured(_ error: Error)

}
protocol PresenterToViewRestaurantProtocol: AnyObject {
    func showLoadingAnimation()
    func removeLoadingAnimation()
    func reloadData()
}
protocol PresenterToRouterRestaurantProtocol {
    var navigationController: UINavigationController? { get set }
    static func createModule() -> UINavigationController
    func showHome()
    func showErrorPopUp(message: String)
}
