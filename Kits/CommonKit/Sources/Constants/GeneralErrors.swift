//
//  GeneralErrors.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 13.06.2022.
//

import Foundation

public enum GeneralErrors: LocalizedError {
    case invalidId

    public var errorDescription: String? {
        switch self {
        case .invalidId:
            return "Backend developer burned the automatic increement system and we are fired"
        }
    }
}
