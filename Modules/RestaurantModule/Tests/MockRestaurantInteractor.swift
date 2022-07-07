//
//  MockRestaurantInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 8.06.2022.
//

import Foundation
@testable import RestaurantModule

final class MockRestaurantInteractor: RestaurantInteractorInterface {

    var invokedFetchOffers = false
    var invokedFetchOffersCount = 0

    func fetchOffers() {
        invokedFetchOffers = true
        invokedFetchOffersCount += 1
    }

    var invokedFetchNewRestaurants = false
    var invokedFetchNewRestaurantsCount = 0

    func fetchNewRestaurants() {
        invokedFetchNewRestaurants = true
        invokedFetchNewRestaurantsCount += 1
    }

    var invokedFetchRestaurants = false
    var invokedFetchRestaurantsCount = 0

    func fetchRestaurants() {
        invokedFetchRestaurants = true
        invokedFetchRestaurantsCount += 1
    }
}
