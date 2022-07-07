import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(contentsOf: [
        AllDependencies.Kits.commonKit
    ])
    return dependencies
}

let project = Project.makeTarget(
    name: "SignUpValidatorKit",
    hasResources: false,
    dependencies: makeDependencies(),
    hasUnitTest: true
)
