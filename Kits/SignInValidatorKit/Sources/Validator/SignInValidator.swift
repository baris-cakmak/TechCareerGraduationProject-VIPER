//
//  SignInValidator.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 7.06.2022.
//

import Foundation
import CommonKit

public protocol SignInValidatorInterface {
    var signInModel: SignInModel? { get set }
    func validateAll() throws
    func fieldIsNotMissing(signInModel: SignInModel) throws
}

public final class SignInValidator: SignInValidatorInterface {
    public var signInModel: SignInModel?
    public init(signInModel: SignInModel?) {
        self.signInModel = signInModel
    }
    public func validateAll() throws {
        guard let signInModel = signInModel else {
            return
        }
        do {
            try fieldIsNotMissing(signInModel: signInModel)
        } catch {
            throw error
        }
    }
    public func fieldIsNotMissing(signInModel: SignInModel) throws {
        guard !signInModel.email.isEmpty,
            !signInModel.password.isEmpty else {
            throw SignInErrors.missingField
        }
    }
}
