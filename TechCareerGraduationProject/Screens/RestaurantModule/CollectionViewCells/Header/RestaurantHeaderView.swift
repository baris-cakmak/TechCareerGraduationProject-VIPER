//
//  RestaurantHeaderView.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import UIKit

class RestaurantHeaderView: UICollectionReusableView {
    
    private let label: UILabel = {
        let headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func configureReusableView(with text: String) {
        label.text = text
    }
}
