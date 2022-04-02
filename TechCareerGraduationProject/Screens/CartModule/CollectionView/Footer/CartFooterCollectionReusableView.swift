//
//  CartFooterCollectionReusableView.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 26.03.2022.
//

import UIKit

protocol CartFooterCollectionReusableViewDelegate: AnyObject{
    func didTapOrderNow()
}


class CartFooterCollectionReusableView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    // MARK: - Delegate
    
    weak var delegate: CartFooterCollectionReusableViewDelegate?
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Action
    
    @IBAction func didTapOrderNowButton(_ sender: UIButton) {
        delegate?.didTapOrderNow()
    }
    
}
