//
//  RestaurantInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation
import DependencyManagerKit
import DummyRestaurantApiKit

protocol RestaurantInteractorInterface {
    func fetchOffers()
    func fetchNewRestaurants()
    func fetchRestaurants()
}

final class RestaurantInteractor: RestaurantInteractorInterface {
    weak var presenter: RestaurantInteractorOutputInterface?
    
    @Dependency private var dummyNetworkManager: MyDummyRestaurantAPINetworkable
}
// MARK: - Method 
extension RestaurantInteractor {
    func fetchOffers() {
        dummyNetworkManager.getOffers { [presenter] result in
            presenter?.didOfferCallFinished(result)
        }
    }
    
    func fetchNewRestaurants() {
        dummyNetworkManager.getNewRestaurants { [presenter] result in
            presenter?.didFetchNewRestaurants(result)
        }
    }
    
    func fetchRestaurants() {
        dummyNetworkManager.getRestaurants { [presenter] result in
            presenter?.didFetchRestaurants(result)
        }
    }
}
