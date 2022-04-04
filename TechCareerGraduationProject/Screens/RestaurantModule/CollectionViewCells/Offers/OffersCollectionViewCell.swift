//
//  OffersCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import SDWebImage

class OffersCollectionViewCell: UICollectionViewCell {

    let cornerRadius: CGFloat = 30.0
    
    // MARK: - UI Properties
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    
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
    
    func configureCell(with offerViewModel: OfferViewModel) {
        offerImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        offerImageView.sd_setImage(with: URL(string: "\(offerViewModel.imageUrlString)"),
                                   placeholderImage: UIImage(named: "placeholderImage")!,
                                   options: [.scaleDownLargeImages])
        
        testLabel.text = offerViewModel.title
    }
    
    func configureCellAppeareance() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 9.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
