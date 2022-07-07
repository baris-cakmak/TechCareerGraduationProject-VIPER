//
//  MockCartFooterDelegate.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 18.06.2022.
//

import Foundation
@testable import TechCareerGraduationProject
@testable import CartModule
@testable import FirebaseCore

final class MockCartFooterDelegate: CartFooterCollectionReusableViewDelegate {
    var invokedDidTapOrderNow = false
    var invokedDidTapOrderNowCount = 0

    func didTapOrderNow() {
        invokedDidTapOrderNow = true
        invokedDidTapOrderNowCount += 1
    }
}
