//
//  MyDummyRestaurantAPINetworkManager.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation
import Moya

protocol MyDummyRestaurantAPINetworkable {
    
        var provider: MoyaProvider<MyDummyRestaurantAPIEndpoint> { get }
        func getOffers(completion: @escaping (Result<[RestaurantOfferResponseModel],Error>) -> Void)
        func getNewRestaurants(completion: @escaping (Result<[RestaurantNewRestaurantsResponseModel],Error>) -> Void)
        func getRestaurants(completion: @escaping (Result<[RestaurantResponseModel],Error>) -> Void)
}

class MyDummyRestaurantAPINetworkManager: MyDummyRestaurantAPINetworkable {

    var provider: MoyaProvider<MyDummyRestaurantAPIEndpoint> = MoyaProvider<MyDummyRestaurantAPIEndpoint>(plugins: [NetworkLoggerPlugin.verbose])
    
    func getOffers(completion: @escaping (Result<[RestaurantOfferResponseModel], Error>) -> Void) {
        request(target: .getOffers, completion: completion)
    }
    func getNewRestaurants(completion: @escaping (Result<[RestaurantNewRestaurantsResponseModel], Error>) -> Void) {
        request(target: .getNewRestaurants, completion: completion)
    }
    func getRestaurants(completion: @escaping (Result<[RestaurantResponseModel], Error>) -> Void) {
        request(target: .getRestaurants, completion: completion)
    }
}

extension MyDummyRestaurantAPINetworkManager {
    
    func request<T: Decodable>(target: MyDummyRestaurantAPIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    
                    completion(.success(results))
                }
                catch let error {
                    
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
