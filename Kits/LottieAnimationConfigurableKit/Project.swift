import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(contentsOf: [
        .external(name: ExternalSwiftPackageManager.lottie.description)
    ])
    return dependencies
}
let project = Project.makeTarget(
    name: "LottieAnimationConfigurableKit",
    hasResources: false,
    dependencies: makeDependencies()
)
