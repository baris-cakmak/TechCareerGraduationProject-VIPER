import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(
        contentsOf: [
            .external(name: ExternalSwiftPackageManager.firebaseAnalytics.description),
            AllDependencies.Kits.lottieAnimationConfigurableKit,
            .external(name: ExternalSwiftPackageManager.sDWebImage.description),
            AllDependencies.Kits.dummyRestaurantApiKit,
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.ModuleInterfaces.restaurantModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.homeModuleInterfaceTargetDependency,
            AllDependencies.Kits.commonKit
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.restaurantModuleInterfaceTarget
    ])
    return targets
}
let project = Project.makeTarget(
    name: "RestaurantModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets()
)
