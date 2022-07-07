//
//  RestaurantCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import CommonKit
import SDWebImage

protocol RestaurantCellInterface: AnyObject {
    func configureCellAppeareance()
    func configureRestaurantNameLabel(_ text: String)
    func configurePriceLabel(_ text: String)
    func configureDeliveryCostLabel(_ text: String)
    func configureAdressLabel(_ text: String)
    func configureRestaurantPointLabel(_ text: String)
    func configurePointBackgroundView(_ color: Colors)
    func configureRestaurantFoodImageView(with url: URL)
}

final class RestaurantCollectionViewCell: UICollectionViewCell {
    // MARK: - Presenter
    var presenter: RestaurantCellPresenterInterface? {
        didSet {
            presenter?.loadCell()
        }
    }
    // MARK: - UI Properties
    
    @IBOutlet weak private var pointBackgroundView: CustomView!
    @IBOutlet weak private var restaurantDeliveryCostLabel: UILabel!
    @IBOutlet weak private var restaurantPriceLabel: UILabel!
    @IBOutlet weak private var restaurantAdressLabel: UILabel!
    @IBOutlet weak private var restaurantNameLabel: UILabel!
    @IBOutlet weak private var restaurantPointLabel: UILabel!
    @IBOutlet weak private var restaurantFoodImage: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = CellConstants.cornerRadius
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
extension RestaurantCollectionViewCell {
    private enum CellConstants {
        static let shadowRadius: CGFloat = 8.0
        static let shadowColor: CGColor = UIColor.black.cgColor
        static let shadowOpacity: Float = 0.4
        static let shadowOffset: CGSize = .init(width: .zero, height: 5)
        static let cornerRadius: CGFloat = 35.0
    }
}
// MARK: - RestaurantCellInterface
extension RestaurantCollectionViewCell: RestaurantCellInterface {
    func configureCellAppeareance() {
        contentView.layer.cornerRadius = CellConstants.cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = CellConstants.cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = CellConstants.shadowRadius
        layer.shadowColor = CellConstants.shadowColor
        layer.shadowOpacity = CellConstants.shadowOpacity
        layer.shadowOffset = CellConstants.shadowOffset
    }
    
    func configurePriceLabel(_ text: String) {
        restaurantPriceLabel.text = text
    }
    
    func configureDeliveryCostLabel(_ text: String) {
        restaurantDeliveryCostLabel.text = text
    }
    
    func configureAdressLabel(_ text: String) {
        restaurantAdressLabel.text = text
    }
    
    func configureRestaurantPointLabel(_ text: String) {
        restaurantPointLabel.text = text
    }
    
    func configurePointBackgroundView(_ color: Colors) {
        pointBackgroundView.backgroundColor = color.colorDescription
    }
    
    func configureRestaurantNameLabel(_ text: String) {
        restaurantNameLabel.text = text
    }
    
    func configureRestaurantFoodImageView(with url: URL) {
        restaurantFoodImage.sd_setImage(
            with: url,
            placeholderImage: Constants.Image.placeholderImage,
            options: [.scaleDownLargeImages, .delayPlaceholder]
        )
    }
}
