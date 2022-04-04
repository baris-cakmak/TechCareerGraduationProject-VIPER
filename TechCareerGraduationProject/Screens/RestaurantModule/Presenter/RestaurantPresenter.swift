//
//  RestaurantPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit

enum Section: Int, CaseIterable {
    case offers
    case newRestaurants
    case restaurants
}

class RestaurantPresenter: ViewToPresenterRestaurantProtocol {
    
    weak var view: PresenterToViewRestaurantProtocol?
    
    var interactor: PresenterToInteractorRestaurantProtocol?
    
    var router: PresenterToRouterRestaurantProtocol?
    
    var offerViewModels: [OfferViewModel]?
    
    var newRestaurantViewModels: [NewRestaurantViewModel]?
    
    var restaurantViewModels: [RestaurantViewModel]?

    // MARK: - Method
    
    func viewDidLoad() {
        view?.showLoadingAnimation()
        getOfferViewModels()
        getNewRestaurantViewModels()
        getRestaurantViewModels()
    }
    
    func numberOfRowInSectionOffer() -> Int {
        offerViewModels?.count ?? 0
    }
    
    func numberOfRowInSectionNewRestaurant() -> Int {
        newRestaurantViewModels?.count ?? 0
    }
    
    func numberOfRowsInSectionRestaurant() -> Int {
        restaurantViewModels?.count ?? 0
    }
    
    func getOfferViewModels() {
        interactor?.fetchOffers()
    }
    
    func getNewRestaurantViewModels() {
        interactor?.fetchNewRestaurants()
    }
    
    func getRestaurantViewModels() {
        interactor?.fetchRestaurants()
    }
    func goToHome() {
        router?.showHome()
    }
    
    func getOfferViewModel(at indexPath: IndexPath) -> OfferViewModel {
        return offerViewModels![indexPath.item]
    }
    
    func getNewRestaurantViewModel(at indexPath: IndexPath) -> NewRestaurantViewModel {
        return newRestaurantViewModels![indexPath.item]
    }
    
    
    func getRestaurantViewModel(at indexPath: IndexPath) -> RestaurantViewModel {
        return restaurantViewModels![indexPath.item]
    }
    
    func handleRestaurantStatus(_ status: RestaurantStatus) -> UIColor {
        switch status {
        case .excellent:
            return #colorLiteral(red: 0.006603668444, green: 0.875836134, blue: 0.06679136306, alpha: 1)
        case .bad:
            return #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        case .good:
            return #colorLiteral(red: 0.6321938634, green: 0.8927814364, blue: 0.4585395455, alpha: 1)
        }
    }
    
}

// MARK: - Interactor To Presenter
extension RestaurantPresenter: InteractorToPresenterRestaurantProtocol {

    func didFetchOffers(_ offerResponse: [RestaurantOfferResponseModel]) {
        offerViewModels = offerResponse.map({ offer -> OfferViewModel in
            return OfferViewModel(title: offer.title, imageUrlString: offer.imageUrl)
        })
        view?.removeLoadingAnimation()
        view?.reloadData()
    }
    
    func didFetchNewRestaurants(_ newRestaurantsResponse: [RestaurantNewRestaurantsResponseModel]) {
        newRestaurantViewModels = newRestaurantsResponse.map({ newRestaurant -> NewRestaurantViewModel in
            return NewRestaurantViewModel(restaurantPointBackgroundColor: handleRestaurantStatus(newRestaurant.status), restaurantImageUrlString: newRestaurant.restaurantImageUrl, categoryTitle: newRestaurant.category.rawValue, restaurantPoint: newRestaurant.restaurantPoint, restaurantName: newRestaurant.restaurantName)
        })
        view?.removeLoadingAnimation()
        view?.reloadData()
    }
    
    func didFetchRestaurants(_ restaurantResponse: [RestaurantResponseModel]) {
        restaurantViewModels = restaurantResponse.map({ restaurant -> RestaurantViewModel in
            return RestaurantViewModel(restaurantPointBackgroundColor: handleRestaurantStatus(restaurant.status), restaurantImageUrlString: restaurant.restaurantImageUrl, restaurantAdress: restaurant.adress, restaurantPoint: restaurant.restaurantPoint, restaurantName: restaurant.restaurantName, restaurantDeliveryCost: restaurant.deliveryCost, restaurantMinimumCost: restaurant.minimumPrice)
        })
        view?.removeLoadingAnimation()
        view?.reloadData()
    }
    
    
    func didErrorOccured(_ error: Error) {
        router?.showErrorPopUp(message: "Network error due to \(error.localizedDescription)")
        view?.removeLoadingAnimation()

    }
    
    
}
