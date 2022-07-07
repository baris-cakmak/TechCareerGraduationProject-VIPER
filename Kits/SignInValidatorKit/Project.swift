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
    name: "SignInValidatorKit",
    hasResources: false,
    dependencies: makeDependencies(),
    hasUnitTest: true
)
