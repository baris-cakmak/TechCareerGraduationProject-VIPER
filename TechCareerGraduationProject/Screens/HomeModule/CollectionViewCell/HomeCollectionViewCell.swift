//
//  HomeCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Properties
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealPriceLabel: UILabel!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 30

        
    }
    
    // MARK: - Helper
    
    func configureModel(with viewModel: MealViewModel) {
        let thumbnailSize = CGSize(width: scale * 70, height: scale * 70)
        mealImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        mealImageView.sd_setImage(with: viewModel.mealImageUrl, placeholderImage: UIImage(named: "placeholderImage")!, options: [.scaleDownLargeImages], context: [.imageThumbnailPixelSize : thumbnailSize])
        mealNameLabel.text = viewModel.mealName
        mealPriceLabel.text = "₺ \(viewModel.mealPrice)"
    }

}

