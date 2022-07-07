//
//  CartFooterCollectionReusableView.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 26.03.2022.
//

import UIKit

protocol CartFooterViewInterface: AnyObject {
    func changePrice(with footerViewModel: CartFooterViewModel)
}

final class CartFooterCollectionReusableView: UICollectionReusableView {
    // MARK: - Presenter
    var presenter: CartFooterPresenter?
    // MARK: - UI Properties
    @IBOutlet weak private var priceLabel: UILabel!
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Constant
extension CartFooterCollectionReusableView {
    private enum CartFooterConstants {
        static let priceFadeInDuration: CGFloat = 0.3
        static let priceFadeInDelay: CGFloat = 0.15
        static let priceAlpha: CGFloat = .zero
    }
}
// MARK: - Presenter Output
extension CartFooterCollectionReusableView: CartFooterViewInterface {
    func changePrice(with footerViewModel: CartFooterViewModel) {
        priceLabel.alpha = CartFooterConstants.priceAlpha
        priceLabel.text = footerViewModel.totalPrice
        priceLabel.fadeIn(duration: CartFooterConstants.priceFadeInDuration, delay: CartFooterConstants.priceFadeInDelay)
    }
}
// MARK: - Action
extension CartFooterCollectionReusableView {
    @IBAction private func didTapOrderNowButton(_ sender: UIButton) {
        presenter?.didTapOrderNow()
    }
}
// MARK: - Helper
extension CartFooterCollectionReusableView {
    func calculateTotalPrice(of pricesInCart: [Int]) {
        presenter?.calculateTotalPrice(of: pricesInCart)
    }
}
