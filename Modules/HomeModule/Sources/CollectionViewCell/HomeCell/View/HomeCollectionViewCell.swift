//
//  HomeCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit
import SDWebImage
import CommonKit

protocol HomeCellInterface: AnyObject {
    func configureCellAppearance()
    func configurePriceLabel(_ text: String)
    func configureMealImageView(with url: URL)
    func configureMealNameLabel(_ text: String)
}

final class HomeCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Properties
    
    @IBOutlet weak private var mealImageView: UIImageView!
    @IBOutlet weak private var mealNameLabel: UILabel!
    @IBOutlet weak private var mealPriceLabel: UILabel!
    
    // MARK: - Presenter
    var presenter: HomeCellPresenterInterface? {
        didSet {
            presenter?.loadCell()
        }
    }
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Constant
extension HomeCollectionViewCell {
    private enum CellConstant {
        static let cornerRadius: CGFloat = 30.0
    }
}
// MARK: - HomeCellInterface
extension HomeCollectionViewCell: HomeCellInterface {
    func configureCellAppearance() {
        layer.cornerRadius = CellConstant.cornerRadius
    }
    func configurePriceLabel(_ text: String) {
        mealPriceLabel.text = text
    }
    func configureMealImageView(with url: URL) {
        mealImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        mealImageView.sd_setImage(
            with: url,
            placeholderImage: Constants.Image.placeholderImage,
            options: [.scaleDownLargeImages]
        )
    }
    func configureMealNameLabel(_ text: String) {
        mealNameLabel.text = text
    }
}
