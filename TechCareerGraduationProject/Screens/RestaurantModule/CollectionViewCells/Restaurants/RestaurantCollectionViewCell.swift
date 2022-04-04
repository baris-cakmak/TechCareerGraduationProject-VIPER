//
//  RestaurantCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import SDWebImage

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    let cornerRadius: CGFloat = 35.0
    
    // MARK: - UI Properties
    
    @IBOutlet weak var pointBackgroundView: CustomView!
    @IBOutlet weak var restaurantDeliveryCostLabel: UILabel!
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantAdreesLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantPoint: UILabel!
    @IBOutlet weak var restaurantFoodImage: UIImageView!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
//        configureCellAppeareance()
        layer.cornerRadius = 30
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    // MARK: - Helper
    
    func configureCell(with viewModel: RestaurantViewModel) {
        restaurantPriceLabel.text = viewModel.restaurantMinimumCost
        restaurantDeliveryCostLabel.text = viewModel.restaurantDeliveryCost
        restaurantAdreesLabel.text = viewModel.restaurantAdress
        restaurantNameLabel.text = viewModel.restaurantName
        restaurantPoint.text = viewModel.restaurantPoint
        restaurantFoodImage.sd_imageIndicator = SDWebImageActivityIndicator.large

        let thumbnailSize = CGSize(width: 205 * scale, height: 100 * scale) 
        restaurantFoodImage.sd_setImage(with: URL(string: "\(viewModel.restaurantImageUrlString)"), placeholderImage: UIImage(named: "placeholderImage")!, options: [.scaleDownLargeImages, .delayPlaceholder],context: [.imageThumbnailPixelSize : thumbnailSize])
        pointBackgroundView.backgroundColor = viewModel.restaurantPointBackgroundColor
    }
    
    
    
    func configureCellAppeareance() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 5)

    }
}
