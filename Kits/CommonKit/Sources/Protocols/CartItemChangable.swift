//
//  CartItemChangable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 15.06.2022.
//

import Foundation

public protocol CartItemChangable {
    func calculateTotalPrice(count: Double, pricePerItem: Int) -> String
    func handleStepperStatus(orderCount: Double) -> String
}

extension CartItemChangable {
    public func handleStepperStatus(orderCount: Double) -> String {
        orderCount == 1 ? "🥺" : "-"
    }
    public func calculateTotalPrice(count: Double, pricePerItem: Int) -> String {
        let totalPrice = count * Double(pricePerItem)
        return "₺ \(totalPrice.formatted(.number))"
    }
}
