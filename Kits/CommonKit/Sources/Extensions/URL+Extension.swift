//
//  URL+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 14.06.2022.
//

import Foundation

extension URL {
    public static func string(_ urlString: String) -> URL {
        guard let url = URL(string: urlString) else {
            fatalError("Could not initialize \(URL.self) string named \(urlString).")
        }
        return url
    }
}
