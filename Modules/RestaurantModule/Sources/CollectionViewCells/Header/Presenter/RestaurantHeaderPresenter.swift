//
//  RestaurantHeaderViewModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 11.05.2022.
//

import Foundation

protocol RestaurantFooterViewPresenterInterface {
    func configureHeaderView(indexPath: IndexPath?)
}

final class RestaurantFooterViewModel: RestaurantFooterViewPresenterInterface {
    weak private var headerView: RestaurantHeaderView?
    private var headerViewModel: RestaurantHeaderViewModel?
    
    init(headerView: RestaurantHeaderView) {
        self.headerView = headerView
    }
}
// MARK: - Method
extension RestaurantFooterViewModel {
    func configureHeaderView(indexPath: IndexPath?) {
        if let indexPath = indexPath {
            headerViewModel = .init(
                headerBackgroundColor: "blurBackground3",
                headerNameText: "\(Section.allCases[indexPath.section])".titleCased()
            )
        }
        if let headerViewModel = headerViewModel {
            headerView?.configureReusableView(with: headerViewModel)
        }
    }
}
