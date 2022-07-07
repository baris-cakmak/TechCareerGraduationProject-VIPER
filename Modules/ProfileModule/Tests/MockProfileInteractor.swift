//
//  MockProfileInteractor.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 17.06.2022.
//

import Foundation
@testable import ProfileModule

final class MockProfileInteractor: ProfileInteractorInterface {

    var invokedFetchUser = false
    var invokedFetchUserCount = 0

    func fetchUser() {
        invokedFetchUser = true
        invokedFetchUserCount += 1
    }

    var invokedLogoutTheUser = false
    var invokedLogoutTheUserCount = 0

    func logoutTheUser() {
        invokedLogoutTheUser = true
        invokedLogoutTheUserCount += 1
    }
}
