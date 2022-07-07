import ProjectDescription
import ProjectDescriptionHelpers

private func createDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    return dependencies
}
let project = Project.makeTarget(
    name: "OnboardingManagerKit",
    hasResources: false,
    dependencies: createDependencies()
)
