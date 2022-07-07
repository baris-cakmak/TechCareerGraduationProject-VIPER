//
//  Dependencies.swift
//  Config
//
//  Created by Peace on 19.06.2022.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(
            url: "https://github.com/airbnb/lottie-ios.git",
            requirement: .upToNextMajor(from: "3.2.1")
        ),
        .remote(
            url: "https://github.com/SDWebImage/SDWebImage.git",
            requirement: .upToNextMajor(
                from: "5.1.0"
            )
        ),
        .remote(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            requirement: .upToNextMajor(
                from: "8.10.0"
            )
        )
    ],
    platforms: Set(arrayLiteral: .iOS))
