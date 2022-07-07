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
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.Kits.userStorageManager,
            AllDependencies.ModuleInterfaces.homeDetailModuleTargetDependency
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.homeDetailModuleInterfaceTarget
    ])
    return targets
}

let project = Project.makeTarget(
    name: "HomeDetailModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets()
)
