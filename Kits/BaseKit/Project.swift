//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Peace on 2.07.2022.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeTarget(
    name: "BaseKit",
    hasResources: false,
    dependencies: [
        AllDependencies.Kits.commonKit,
        .sdk(name: "XCTest", type: .framework, status: .optional)
    ],
    hasUnitTest: false,
    hasUITest: false,
    targets: [],
    unitTestsDependencies: []
)
