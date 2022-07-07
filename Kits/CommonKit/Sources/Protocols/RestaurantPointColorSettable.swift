//
//  RestaurantPointColorSettable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 19.05.2022.
//

import Foundation

public protocol RestaurantPointColorSettable {
    func handleRestaurantPointBackground(with status: RestaurantStatus) -> Colors
}
extension RestaurantPointColorSettable {
    public func handleRestaurantPointBackground(with status: RestaurantStatus) -> Colors {
        switch status {
        case .excellent:
            return .green

        case .bad:
            return .red

        case .good:
            return .greenish
        }
    }
}
