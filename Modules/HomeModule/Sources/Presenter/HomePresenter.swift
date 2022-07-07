//
//  HomePresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation
import CommonKit

protocol HomePresenterInterface {
    func viewDidLoad()
    func viewDidAppear()
    func numberOfRowsInSection() -> Int
    func getHomeViewModel(at indexPath: IndexPath) -> MealViewModel
    func goToHomeDetail(with indexPath: IndexPath)
    func handleError(_ error: Error)
}

final class HomePresenter: HomePresenterInterface {
    weak private var view: HomePresenterOutputInterface?
    private let interactor: HomeInteractorInterface?
    private let router: HomeRouterInterface?
    private var mealViewModels: [MealViewModel] = []
    init (
        view: HomePresenterOutputInterface?,
        interactor: HomeInteractorInterface?,
        router: HomeRouterInterface?
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: - View To Presenter

extension HomePresenter {
    func viewDidLoad() {
        view?.setNavigationItemTitle(with: Constants.NavigationItem.homeTitle)
        view?.configureMealCollectionView()
        view?.configureAnimation()
        interactor?.getAllMeals()
    }
    
    func viewDidAppear() {
        interactor?.fetchMealsAtTheCart()
    }
    
    func numberOfRowsInSection() -> Int {
        mealViewModels.count
    }
    
    func getHomeViewModel(at indexPath: IndexPath) -> MealViewModel {
        mealViewModels[indexPath.row]
    }
    
    func goToHomeDetail(with indexPath: IndexPath) {
        router?.showHomeDetail(with: mealViewModels[indexPath.row])
    }

    func handleError(_ error: Error) {
        router?.showAlert(message: error.localizedDescription)
        view?.updateBadgeCountOfCartTabBar(badgeValue: nil)
    }
}
// MARK: - Helper
extension HomePresenter {
    private func makeMealViewModels(with mealModels: [Meal]) throws -> [MealViewModel] {
        try mealModels.compactMap { meal -> MealViewModel in
            guard meal.mealId != nil else {
                throw GeneralErrors.invalidId
                // fatal error......
            }
            var viewModel: MealViewModel = .init(
                mealName: meal.mealName,
                mealPrice: meal.mealPrice,
                mealDesc: meal.mealDesc
            )
            if let imageUrlString = meal.mealImageUrlString {
                viewModel.mealImageUrl = URL(string: Constants.MealApi.apiImagesConstantUrlString.appending(imageUrlString))
            }
            return viewModel
        }
    }
}
// MARK: - Interactor To Presenter
protocol HomeInteractorOutputInterface: AnyObject {
    func handleFetchingAllMeals(result: Result<MealResponseModel, Error>)
    func handleMealsAtTheCart(result: Result<MealCartResponseModel, Error>)
}

extension HomePresenter: HomeInteractorOutputInterface {
    func handleFetchingAllMeals(result: Result<MealResponseModel, Error>) {
        view?.removeAnimation()
        switch result {
        case .success(let mealResponseModel):
            do {
                mealViewModels = try makeMealViewModels(with: mealResponseModel.meal)
            } catch {
                // inform backend
                print(error)
                return
            }
            view?.reloadData()
            
        case .failure(let error):
            handleError(error)
        }
    }
    
    func handleMealsAtTheCart(result: Result<MealCartResponseModel, Error>) {
        switch result {
        case .success(let mealAtTheCartResponseModel):
            
            let mealCountAtTheCartText = mealAtTheCartResponseModel.mealCart.isEmpty ? nil : "\(mealAtTheCartResponseModel.mealCart.count)"
            view?.updateBadgeCountOfCartTabBar(badgeValue: mealCountAtTheCartText)
            
        case .failure(let error):
            print(error.localizedDescription)
            view?.updateBadgeCountOfCartTabBar(badgeValue: nil)
            //            handleError(error)
        }
    }
}
