import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(
        contentsOf: [
            AllDependencies.Kits.commonKit,
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.Kits.onboardingManager,
            AllDependencies.Kits.userStorageManager,
            AllDependencies.Kits.userManager,
            AllDependencies.ModuleInterfaces.rootModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.loginModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.onboardingModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.mainTabBarModuleInterfaceTargetDependency
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.rootModuleInterfaceTarget
    ])
    return targets
}

let project = Project.makeTarget(
    name: "RootModule",
    hasResources: false,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets(),
    unitTestsDependencies: []
)
