//
//  OffersCellBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 18.05.2022.
//

import Foundation

enum OffersCellBuilder {
    static func createCell(_ cell: OffersCollectionViewCell, offerViewModel: OfferViewModel) {
        cell.presenter = OffersPresenter(offerViewModel: offerViewModel, view: cell)
    }
}
