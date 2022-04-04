//
//  NewRestaurantsCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import SDWebImage

class NewRestaurantsCollectionViewCell: UICollectionViewCell {

    let cornerRadius: CGFloat = 30
    
    // MARK: - UI Properties
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var restaurantPoint: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantPointBackgroundView: CustomView!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellAppeareance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    // MARK: - Helper
    
    func configureCell(with viewModel: NewRestaurantViewModel) {
        let thumbnailSize = CGSize(width: 50 * scale, height: 50 * scale)
        restaurantImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        restaurantImageView.sd_setImage(with: URL(string: "\(viewModel.restaurantImageUrlString)"),
                                   placeholderImage: UIImage(named: "placeholderImage")!,
                                        options: [.scaleDownLargeImages, .waitStoreCache], context: [.imageThumbnailPixelSize : thumbnailSize])
        restaurantPoint.text = viewModel.restaurantPoint
        categoryLabel.text = viewModel.categoryTitle
        restaurantPointBackgroundView.backgroundColor = viewModel.restaurantPointBackgroundColor
        restaurantNameLabel.text = viewModel.restaurantName
    }
    func configureCellAppeareance() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 6)
    }
}
