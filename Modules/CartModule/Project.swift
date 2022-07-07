import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(
        contentsOf: [
            .external(name: ExternalSwiftPackageManager.firebaseAnalytics.description),
            AllDependencies.XCFrameworks.gmStepper,
            .external(name: ExternalSwiftPackageManager.sDWebImage.description),
            AllDependencies.Kits.mealsAPI,
            AllDependencies.Kits.lottieAnimationConfigurableKit,
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.Kits.userStorageManager,
            AllDependencies.ModuleInterfaces.cartModuleInterfaceTargetDependency
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(
        contentsOf: [
            AllDependencies.ModuleInterfaces.cartModuleInterfaceTarget,
        ]
    )
    return targets
}
let project = Project.makeTarget(
    name: "CartModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets(),
    unitTestsDependencies: []
)
