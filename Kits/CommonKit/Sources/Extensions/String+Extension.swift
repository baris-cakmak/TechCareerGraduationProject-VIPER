//
//  String+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.04.2022.
//

import Foundation

extension String {
    public func titleCased() -> String {
        self.replacingOccurrences(of: "([A-Z])", with: " $0", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
