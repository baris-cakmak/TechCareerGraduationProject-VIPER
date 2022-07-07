//
//  NewRestaurantsCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import SDWebImage
import CommonKit

protocol NewRestaurantCellInterface: AnyObject {
    func configureCellAppeareance()
    func configureRestaurantNameLabel(_ text: String)
    func configureCategoryLabel(_ text: String)
    func configurePointLabel(_ text: String)
    func configureRestaurantImageView(_ imageUrl: URL)
    func configureRestaurantPointBackgroundColor(_ color: Colors)
}

final class NewRestaurantsCollectionViewCell: UICollectionViewCell {
    // MARK: - Presenter
    var presenter: NewRestaurantCellPresenterInterface? {
        didSet {
            presenter?.loadCell()
        }
    }
    // MARK: - UI Properties
    @IBOutlet weak private var restaurantNameLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var restaurantPoint: UILabel!
    @IBOutlet weak private var restaurantImageView: UIImageView!
    @IBOutlet weak private var restaurantPointBackgroundView: CustomView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: NewRestaurantConstants.cornerRadius
        ).cgPath
    }
}
// MARK: - Constant
extension NewRestaurantsCollectionViewCell {
    private enum NewRestaurantConstants {
        static let cornerRadius: CGFloat = 30
        static let shadowRadius: CGFloat = 3.0
        static let shadowColor: CGColor = UIColor.black.cgColor
        static let shadowOpacity: Float = 0.2
        static let shadowOffset: CGSize = .init(width: .zero, height: 6)
    }
}

// MARK: - NewRestaurantCellInterface
extension NewRestaurantsCollectionViewCell: NewRestaurantCellInterface {
    func configureRestaurantNameLabel(_ text: String) {
        restaurantNameLabel.text = text
    }
    func configureCategoryLabel(_ text: String) {
        categoryLabel.text = text
    }
    func configurePointLabel(_ text: String) {
        restaurantPoint.text = text
    }
    func configureRestaurantImageView(_ imageUrl: URL) {
        restaurantImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        restaurantImageView.sd_setImage(
            with: imageUrl,
            placeholderImage: Constants.Image.placeholderImage,
            options: [.scaleDownLargeImages]
        )
    }
    func configureRestaurantPointBackgroundColor(_ color: Colors) {
        restaurantPointBackgroundView.backgroundColor = color.colorDescription
    }
    func configureCellAppeareance() {
        contentView.layer.cornerRadius = NewRestaurantConstants.cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = NewRestaurantConstants.cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = NewRestaurantConstants.shadowRadius
        layer.shadowColor = NewRestaurantConstants.shadowColor
        layer.shadowOpacity = NewRestaurantConstants.shadowOpacity
        layer.shadowOffset = NewRestaurantConstants.shadowOffset
    }
}
