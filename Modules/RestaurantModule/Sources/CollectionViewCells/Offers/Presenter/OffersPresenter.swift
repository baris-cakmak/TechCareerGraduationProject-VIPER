//
//  OffersPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 18.05.2022.
//

import Foundation
import CommonKit

protocol OffersPresenterInterface {
    func loadCell()
}

final class OffersPresenter: OffersPresenterInterface {
    weak private var view: OffersCollectionViewCellInterface?
    private var offerViewModel: OfferViewModel
    
    init(
        offerViewModel: OfferViewModel,
        view: OffersCollectionViewCellInterface
    ) {
        self.offerViewModel = offerViewModel
        self.view = view
    }
}
// MARK: - Helpers
extension OffersPresenter {
    private func setOffersTitleLabel() {
        guard let offerTitle = offerViewModel.title else {
            return
        }
        view?.configureOfferTitleLabel(offerTitle)
    }
    private func setOfferImageView() {
        if let offerImageUrl = offerViewModel.imageUrl {
            view?.configureOfferImageView(with: offerImageUrl)
        } else {
            view?.configureOfferImageView(with: .string(Constants.MealApi.somethingWentWrongUrl))
        }
    }
}

// MARK: - Method
extension OffersPresenter {
    func loadCell() {
        view?.configureCellAppearance()
        setOfferImageView()
        setOffersTitleLabel()
    }
}
