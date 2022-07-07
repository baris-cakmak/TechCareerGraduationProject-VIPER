//
//  RestaurantHeaderView.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import UIKit
import CommonKit

protocol RestaurantHeaderViewInterface {
    func configureReusableView(with headerViewModel: RestaurantHeaderViewModel)
}

final class RestaurantHeaderView: UICollectionReusableView {
    // MARK: - Presenter
    var presenter: RestaurantFooterViewPresenterInterface?
        
    // MARK: - UI Properties
    private let sectionLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.font = Constants.Font.tooGeneralFont
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - SetupUI
extension RestaurantHeaderView {
    private func setupUI() {
        addSubview(sectionLabel)
    }
}
// MARK: - SetupLayout
extension RestaurantHeaderView {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            sectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Layout.tooGeneralInsetConstant),
            sectionLabel.topAnchor.constraint(equalTo: topAnchor),
            sectionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            sectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
// MARK: - Helper
extension RestaurantHeaderView {
    func configureUI(with indexPath: IndexPath) {
        presenter?.configureHeaderView(indexPath: indexPath)
    }
}
// MARK: - RestaurantHeaderViewInterface
extension RestaurantHeaderView {
    func configureReusableView(with headerViewModel: RestaurantHeaderViewModel) {
        sectionLabel.text = headerViewModel.headerNameText
        backgroundColor = .named(headerViewModel.headerBackgroundColor)
    }
}
