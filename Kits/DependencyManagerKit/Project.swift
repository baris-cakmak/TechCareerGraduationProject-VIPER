import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    return dependencies
}
let project = Project.makeTarget(
    name: "DependencyManagerKit",
    hasResources: false,
    dependencies: makeDependencies()
)
