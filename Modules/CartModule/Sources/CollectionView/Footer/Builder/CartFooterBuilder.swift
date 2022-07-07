//
//  CartFooterBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 12.05.2022.
//

import Foundation

enum CartFooterBuilder {
    static func createFooter(of footerView: CartFooterCollectionReusableView, delegate: CartFooterCollectionReusableViewDelegate) {
        footerView.presenter = CartFooterPresenter(view: footerView, delegate: delegate, footerViewModel: .init())
    }
}
