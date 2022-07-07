//
//  HomeDetailPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
// 

import Foundation
import DependencyManagerKit
import UserStorageManagerKit
import CommonKit
import HomeDetailModuleInterface

protocol HomeDetailPresenterInterface {
    func viewDidLoad()
    func calculatePrice(by stepperValue: Double)
    func addMealsToCartInApi(orderCount: Double)
}

final class HomeDetailPresenter: HomeDetailPresenterInterface {
    weak private var view: HomeDetailPresenterOutputInterface?
    private var interactor: HomeDetailInteractorInterface?
    private let router: HomeDetailRouterInterface?
    private let userStorageManager: UserStorageManagerable?
    private var homeDetailViewModel: MealViewModel
    
    private lazy var username = userStorageManager?.getUserEmailForMealAPI()
    
    init(
        view: HomeDetailPresenterOutputInterface?,
        interactor: HomeDetailInteractorInterface?,
        router: HomeDetailRouterInterface?,
        homeDetailViewModel: MealViewModel,
        userStorageManager: UserStorageManagerable
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.homeDetailViewModel = homeDetailViewModel
        self.userStorageManager = userStorageManager
    }
}
// MARK: - View To Presenter

extension HomeDetailPresenter {    
    func viewDidLoad() {
        view?.configureStepperView()
        view?.setBackgroundColor()
        setMealImage()
        setNameLabel()
        setPriceLabel()
        setDescriptionLabel()
    }
    
    func calculatePrice(by stepperValue: Double) {
        guard let unwrappedMealPrice = homeDetailViewModel.mealPrice, let price = Int(unwrappedMealPrice) else {
            return
        }
        let amount = Int(stepperValue)
        let calculatedPrice = price * amount
        view?.didPriceChanged(price: "₺ \(calculatedPrice)")
    }
    
    func addMealsToCartInApi(orderCount: Double) {
        guard
            let unwrappedMealPrice = homeDetailViewModel.mealPrice,
            let mealPrice = Int(unwrappedMealPrice),
            let mealName = homeDetailViewModel.mealName,
            let imageUrl = homeDetailViewModel.mealImageUrl,
            let username = username else {
            return
        }
        
        interactor?.requestModel = .init(
            username: username,
            orderCount: Int(orderCount),
            mealPrice: mealPrice,
            mealImageName: "\(imageUrl)",
            mealName: mealName
        )
        interactor?.addMealsToCart()
    }
}

// MARK: - Helper
extension HomeDetailPresenter {
    private func setDescriptionLabel() {
        if let mealDescText = homeDetailViewModel.mealDesc {
            view?.configureDescriptionLabel(mealDescText)
        }
    }
    private func setNameLabel() {
        if let nameLabelText = homeDetailViewModel.mealName {
            view?.configureMealNameLabel(nameLabelText)
        }
    }
    private func setMealImage() {
        if let imageUrl = homeDetailViewModel.mealImageUrl {
            view?.configureMealImageView(with: imageUrl)
        }
    }
    private func setPriceLabel() {
        if let priceLabelText = homeDetailViewModel.mealPrice {
            view?.configurePriceLabel("₺ \(priceLabelText)")
        }
    }
}
// MARK: - Interactor To Presenter
protocol HomeDetailInteractorOutputInterface: AnyObject {
    func handleMealAddToCart(result: Result<MealSuccessResponseModel, Error>)
}

extension HomeDetailPresenter: HomeDetailInteractorOutputInterface {
    func handleMealAddToCart(result: Result<MealSuccessResponseModel, Error>) {
        switch result {
        case .success:
            router?.popToHomeView()
            
        case .failure(let error):
            router?.showAlert(message: error.localizedDescription)
        }
    }
}
