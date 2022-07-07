//
//  CartFooterPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 12.05.2022.
//

import Foundation
// MARK: - Delegate
protocol CartFooterCollectionReusableViewDelegate: AnyObject {
    func didTapOrderNow()
}
// MARK: - Presenter Interface
protocol CartFooterPresenterInterface {
    func calculateTotalPrice(of pricesInCart: [Int])
    func didTapOrderNow()
}

final class CartFooterPresenter: CartFooterPresenterInterface {
    weak private var view: CartFooterViewInterface?
    weak private var delegate: CartFooterCollectionReusableViewDelegate?
    private var footerViewModel: CartFooterViewModel
    
    init(view: CartFooterViewInterface, delegate: CartFooterCollectionReusableViewDelegate, footerViewModel: CartFooterViewModel) {
        self.view = view
        self.delegate = delegate
        self.footerViewModel = footerViewModel
    }
}
// MARK: - Method
extension CartFooterPresenter {
    func calculateTotalPrice(of pricesInCart: [Int]) {
        var totalPrice: Int = .zero
        pricesInCart.forEach { price in
            totalPrice += price
        }
        footerViewModel.totalPrice = totalPrice.formatted()
        view?.changePrice(with: footerViewModel)
    }
    func didTapOrderNow() {
        delegate?.didTapOrderNow()
    }
}
