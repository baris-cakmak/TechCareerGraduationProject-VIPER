//
//  OnboardingCellBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 20.05.2022.
//

import Foundation

enum OnboardingCellBuilder {
    static func createCell(
        _ cell: OnboardingCollectionViewCell,
        onboardingViewModel: OnboardingViewModel,
        delegate: OnboardingCollectionViewCellDelegate
    ) {
        cell.presenter = OnboardingCellPresenter(
            view: cell,
            onboardingViewModel: onboardingViewModel,
            delegate: delegate
        )
    }
}
