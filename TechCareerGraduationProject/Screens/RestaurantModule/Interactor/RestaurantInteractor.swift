//
//  RestaurantInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation

class RestaurantInteractor: PresenterToInteractorRestaurantProtocol {
    
    weak var presenter: InteractorToPresenterRestaurantProtocol?
    
    var offerResponseModel: [RestaurantOfferResponseModel]?
    
    var newRestaurantResponseModel: [RestaurantNewRestaurantsResponseModel]?
    
    var dummyNetworkManager: MyDummyRestaurantAPINetworkable?
    
    var restaurantResponseModel: [RestaurantResponseModel]?

    
    init(dummyNetworkManager: MyDummyRestaurantAPINetworkable?) {
        self.dummyNetworkManager = dummyNetworkManager
    }
    
    func fetchOffers() {
        dummyNetworkManager?.getOffers(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let offerResponse):
                self.offerResponseModel = offerResponse
                self.presenter?.didFetchOffers(self.offerResponseModel!)
            case .failure(let error):
                self.presenter?.didErrorOccured(error)
            }
        })
    }
    
    func fetchNewRestaurants() {
        dummyNetworkManager?.getNewRestaurants(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newRestaurantResponse):
                self.newRestaurantResponseModel = newRestaurantResponse
                self.presenter?.didFetchNewRestaurants(self.newRestaurantResponseModel!)
            case .failure(let error):
                self.presenter?.didErrorOccured(error)
            }
        })
    }
    
    func fetchRestaurants() {
        dummyNetworkManager?.getRestaurants(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let restaurantResponse):
                self.restaurantResponseModel = restaurantResponse
                self.presenter?.didFetchRestaurants(self.restaurantResponseModel!)
            case .failure(let error):
                self.presenter?.didErrorOccured(error)
            }
        })

    }
    
    
    
}
