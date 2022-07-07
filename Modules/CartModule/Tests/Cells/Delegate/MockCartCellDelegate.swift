//
//  MockCartCellDelegate.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import Foundation
@testable import TechCareerGraduationProject
@testable import CartModule

final class MockCartCellDelegate: CartCollectionViewCellDelegate {

    var invokedUpdateFooterForNewTotalPrice = false
    var invokedUpdateFooterForNewTotalPriceCount = 0
    var invokedUpdateFooterForNewTotalPriceParameters: (cell: CartCollectionViewCellInterface, value: Double)?
    var invokedUpdateFooterForNewTotalPriceParametersList = [(cell: CartCollectionViewCellInterface, value: Double)]()

    func updateFooterForNewTotalPrice(for cell: CartCollectionViewCellInterface, value: Double) {
        invokedUpdateFooterForNewTotalPrice = true
        invokedUpdateFooterForNewTotalPriceCount += 1
        invokedUpdateFooterForNewTotalPriceParameters = (cell, value)
        invokedUpdateFooterForNewTotalPriceParametersList.append((cell, value))
    }

    var invokedDidUserDecidedToDeleteMeal = false
    var invokedDidUserDecidedToDeleteMealCount = 0
    var invokedDidUserDecidedToDeleteMealParameters: (cell: CartCollectionViewCellInterface, cartId: Int)?
    var invokedDidUserDecidedToDeleteMealParametersList = [(cell: CartCollectionViewCellInterface, cartId: Int)]()

    func didUserDecidedToDeleteMeal(for cell: CartCollectionViewCellInterface, by cartId: Int) {
        invokedDidUserDecidedToDeleteMeal = true
        invokedDidUserDecidedToDeleteMealCount += 1
        invokedDidUserDecidedToDeleteMealParameters = (cell, cartId)
        invokedDidUserDecidedToDeleteMealParametersList.append((cell, cartId))
    }
}
