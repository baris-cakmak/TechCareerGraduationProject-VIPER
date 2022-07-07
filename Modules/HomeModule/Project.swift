import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(contentsOf: [
        .external(name: ExternalSwiftPackageManager.firebaseAnalytics.description),
        .external(name: ExternalSwiftPackageManager.lottie.description),
        .external(name: ExternalSwiftPackageManager.sDWebImage.description),
        AllDependencies.Kits.dependencyManagerKit,
        AllDependencies.Kits.mealsAPI,
        AllDependencies.Kits.userStorageManager,
        AllDependencies.Kits.lottieAnimationConfigurableKit,
        AllDependencies.Kits.commonKit,
        AllDependencies.ModuleInterfaces.homeModuleInterfaceTargetDependency,
        AllDependencies.ModuleInterfaces.homeDetailModuleTargetDependency
    ])
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.homeModuleInterfaceTarget
    ])
    return targets
}

let project = Project.makeTarget(
    name: "HomeModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets()
)
