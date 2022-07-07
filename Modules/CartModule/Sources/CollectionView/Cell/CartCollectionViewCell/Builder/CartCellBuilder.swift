//
//  CartCellViewCellBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 16.05.2022.
//

import Foundation

enum CartCollectionViewCellBuilder {
    static func createCartCollectionViewModule(using cell: CartCollectionViewCell, delegate: CartCollectionViewCellDelegate, cartViewModel: CartViewModel) {
        cell.presenter = CartCellPresenter(view: cell, delegate: delegate, cartViewModel: cartViewModel)
    }
}
