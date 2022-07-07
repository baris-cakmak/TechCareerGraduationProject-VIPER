//
//  MockFooterView.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 18.06.2022.
//

import UIKit
@testable import TechCareerGraduationProject
@testable import CartModule

final class MockFooterView: CartFooterViewInterface {

    var invokedChangePrice = false
    var invokedChangePriceCount = 0
    var invokedChangePriceParameters: (footerViewModel: CartFooterViewModel, Void)?
    var invokedChangePriceParametersList = [(footerViewModel: CartFooterViewModel, Void)]()

    func changePrice(with footerViewModel: CartFooterViewModel) {
        invokedChangePrice = true
        invokedChangePriceCount += 1
        invokedChangePriceParameters = (footerViewModel, ())
        invokedChangePriceParametersList.append((footerViewModel, ()))
    }
}
