import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(
        contentsOf: [
            .external(name: ExternalSwiftPackageManager.firebaseAnalytics.description),
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.ModuleInterfaces.restaurantModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.cartModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.profileModuleInterfaceTargetDependency,
            AllDependencies.Kits.mealsAPI
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(
        contentsOf: [
            AllDependencies.ModuleInterfaces.mainTabBarModuleInterfaceTarget,
        ]
    )
    return targets
}
let project = Project.makeTarget(
    name: "MainTabBarModule",
    hasResources: false,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets()
)
