//
//  MyDummyRestaurantAPIEndpoint.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation
import Moya

enum MyDummyRestaurantAPIEndpoint {
    case getOffers
    case getNewRestaurants
    case getRestaurants
}

extension MyDummyRestaurantAPIEndpoint: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://my-json-server.typicode.com/baris-cakmak/dummy-restaurant-api/") else {
            fatalError("api base url is corrupted")
        }
        return url
    }
    var path: String {
        switch self {
        case .getOffers:
            return "offers"
        case .getNewRestaurants:
            return "newRestaurants"
        case .getRestaurants:
            return "restaurants"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getOffers, .getNewRestaurants, .getRestaurants:
            return .get
        }
    }    
    var task: Task {
        switch self {
        case .getOffers, .getNewRestaurants, .getRestaurants:
            return .requestPlain
        }
    }
    // swiftlint: disable discouraged_optional_collection
    var headers: [String: String]? {
        nil
    }
}
