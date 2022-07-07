//
//  RestaurantPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import CommonKit

enum Section: Int, CaseIterable {
    case offers
    case newRestaurants
    case restaurants
}

enum RestaurantKind: String, CaseIterable {
    case basicHeader
}

protocol RestaurantPresenterInterface {
    func viewDidLoad()
    func numberOfRowsInSectionOffer() -> Int
    func numberOfRowsInSectionNewRestaurant() -> Int
    func numberOfRowsInSectionRestaurant() -> Int
    func getOfferViewModel(at indexPath: IndexPath) -> OfferViewModel
    func getNewRestaurantViewModel(at indexPath: IndexPath) -> NewRestaurantViewModel
    func getResturantViewModel(at indexPath: IndexPath) -> RestaurantViewModel
    func goToHome()
    func didErrorOccured(error: Error)
}

final class RestaurantPresenter: RestaurantPresenterInterface {
    weak private var view: RestaurantPresenterOutputInterface?
    private let interactor: RestaurantInteractorInterface?
    private let router: RestaurantRouterInterface?
    
    private var offerViewModels: [OfferViewModel] = []
    private var resturantViewModels: [RestaurantViewModel] = []
    private var newRestaurantViewModels: [NewRestaurantViewModel] = []

    init(
        view: RestaurantPresenterOutputInterface?,
        interactor: RestaurantInteractorInterface?,
        router: RestaurantRouterInterface?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: - View To Presenter
extension RestaurantPresenter {
    func viewDidLoad() {
        view?.configureRestaurantCollectionView()
        view?.setNavigationItemTitle(with: Constants.NavigationItem.restaurantTitle)
        view?.configureAnimation()
        interactor?.fetchOffers()
        interactor?.fetchNewRestaurants()
        interactor?.fetchRestaurants()
    }
    func numberOfRowsInSectionOffer() -> Int {
        offerViewModels.count
    }
    func numberOfRowsInSectionNewRestaurant() -> Int {
        newRestaurantViewModels.count
    }
    func numberOfRowsInSectionRestaurant() -> Int {
        resturantViewModels.count
    }
    func goToHome() {
        router?.showHome()
    }
    func getOfferViewModel(at indexPath: IndexPath) -> OfferViewModel {
        offerViewModels[indexPath.item]
    }
    func getResturantViewModel(at indexPath: IndexPath) -> RestaurantViewModel {
        resturantViewModels[indexPath.item]
    }
    func getNewRestaurantViewModel(at indexPath: IndexPath) -> NewRestaurantViewModel {
        newRestaurantViewModels[indexPath.item]
    }
    func didErrorOccured(error: Error) {
        router?.showAlert(message: "Error due to \(error.localizedDescription)")
    }
}
// MARK: - Helper
extension RestaurantPresenter {
    private func makeOfferViewModel(with offerModels: [RestaurantOfferResponseModel]) {
        offerViewModels = offerModels.map { offerModel in
            var viewModel: OfferViewModel = .init(title: offerModel.title)
            if let imageUrlString = offerModel.imageUrlString {
                viewModel.imageUrl = .init(string: imageUrlString)
            }
            return viewModel
        }
    }
    private func makeNewRestaurantViewModel(with newRestaurantModels: [RestaurantNewRestaurantsResponseModel]) {
        newRestaurantViewModels = newRestaurantModels.map { newRestaurantModel in
            var viewModel: NewRestaurantViewModel = .init(
                categoryTitle: newRestaurantModel.category?.rawValue,
                restaurantPoint: newRestaurantModel.restaurantPoint,
                restaurantName: newRestaurantModel.restaurantName,
                restaurantStatus: newRestaurantModel.status
            )
                
            if let imageUrlString = newRestaurantModel.restaurantImageUrlString {
                viewModel.restaurantImageUrl = .init(string: imageUrlString)
            }
            
            if let restaurantStatus = newRestaurantModel.status {
                viewModel.restaurantPointBackgroundColor = handleRestaurantPointBackground(with: restaurantStatus)
            }
            return viewModel
        }
    }
    private func makeRestaurantViewModel(with restaurantModels: [RestaurantResponseModel]) {
        resturantViewModels = restaurantModels.map { restaurant in
            var viewModel: RestaurantViewModel = .init(
                restaurantAdress: restaurant.adress,
                restaurantPoint: restaurant.restaurantPoint,
                restaurantName: restaurant.restaurantName,
                restaurantDeliveryCost: restaurant.deliveryCost,
                restaurantMinimumCost: restaurant.minimumPrice
            )
            if let imageUrlString = restaurant.restaurantImageUrl {
                viewModel.restaurantImageUrl = .init(string: imageUrlString)
            }
            if let restaurantStatus = restaurant.status {
                viewModel.restaurantPointBackgroundColor = handleRestaurantPointBackground(with: restaurantStatus)
            }
            return viewModel
        }
    }
}

// MARK: - Interactor To Presenter
protocol RestaurantInteractorOutputInterface: AnyObject {
    func didFetchNewRestaurants(_ result: Result <[RestaurantNewRestaurantsResponseModel], Error>)
    func didFetchRestaurants(_ result: Result <[RestaurantResponseModel], Error>)
    func didOfferCallFinished(_ result: Result<[RestaurantOfferResponseModel], Error>)
}

extension RestaurantPresenter: RestaurantInteractorOutputInterface {
    func didFetchNewRestaurants(_ result: Result<[RestaurantNewRestaurantsResponseModel], Error>) {
        view?.removeAnimation()
        switch result {
        case .success(let newRestaurants):
            makeNewRestaurantViewModel(with: newRestaurants)
            view?.reloadData()

        case .failure(let error):
            didErrorOccured(error: error)
        }
    }

    func didOfferCallFinished(_ result: Result<[RestaurantOfferResponseModel], Error>) {
        view?.removeAnimation()
        switch result {
        case .success(let responseModel):
            makeOfferViewModel(with: responseModel)
            view?.reloadData()

        case .failure(let error):
            didErrorOccured(error: error)
        }
    }
    func didFetchRestaurants(_ result: Result<[RestaurantResponseModel], Error>) {
        view?.removeAnimation()
        switch result {
        case .success(let restaurantResponse):
            makeRestaurantViewModel(with: restaurantResponse)
            view?.reloadData()

        case.failure(let error):
            didErrorOccured(error: error)
        }
    }
}
// MARK: - RestaurantPointColorSettable
extension RestaurantPresenter: RestaurantPointColorSettable {
}
