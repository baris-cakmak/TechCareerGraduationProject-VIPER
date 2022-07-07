//
//  OffersCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import CommonKit
import SDWebImage

protocol OffersCollectionViewCellInterface: AnyObject {
    func configureCellAppearance()
    func configureOfferTitleLabel(_ text: String)
    func configureOfferImageView(with url: URL)
}

final class OffersCollectionViewCell: UICollectionViewCell {
    // MARK: - Presenter
    var presenter: OffersPresenterInterface? {
        didSet {
            presenter?.loadCell()
        }
    }
    // MARK: - UI Properties
    @IBOutlet weak private var offerImageView: UIImageView!
    @IBOutlet weak private var offerLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: CellConstants.cornerRadius
        ).cgPath
    }
}
// MARK: - Constants
extension OffersCollectionViewCell {
    private enum CellConstants {
        static let cornerRadius: CGFloat = 30.0
        static let shadowRadius: CGFloat = 9.0
        static let shadowOpacity: Float = 0.4
        static let shadowOffset: CGSize = .init(width: 0, height: 5)
        static let shadowColor: CGColor = UIColor.black.cgColor
    }
}
// MARK: - OffersCollectionViewCellInterface
extension OffersCollectionViewCell: OffersCollectionViewCellInterface {
    func configureOfferTitleLabel(_ text: String) {
        offerLabel.text = text
    }
    
    func configureOfferImageView(with url: URL) {
        offerImageView.sd_setImage(
            with: url,
            placeholderImage: Constants.Image.placeholderImage,
            options: [.scaleDownLargeImages]
        )
    }
    
    func configureCellAppearance() {
        contentView.layer.cornerRadius = CellConstants.cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = CellConstants.cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = CellConstants.shadowRadius
        layer.shadowColor = CellConstants.shadowColor
        layer.shadowOpacity = CellConstants.shadowOpacity
        layer.shadowOffset = CellConstants.shadowOffset
    }
}
