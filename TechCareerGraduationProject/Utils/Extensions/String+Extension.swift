//
//  String+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import Foundation

extension String {
    func titleCased() -> String {
        return self.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
