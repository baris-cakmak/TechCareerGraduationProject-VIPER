import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(contentsOf: [
        AllDependencies.XCFrameworks.moya,
        AllDependencies.XCFrameworks.alamofire,
        AllDependencies.Kits.commonKit
    ])
    return dependencies
}
let project = Project.makeTarget(
    name: "MealApiKit",
    hasResources: false,
    dependencies: makeDependencies()
)
