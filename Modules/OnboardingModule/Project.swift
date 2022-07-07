import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(
        contentsOf: [
            .external(name: ExternalSwiftPackageManager.firebaseAnalytics.description),
            AllDependencies.ModuleInterfaces.onboardingModuleInterfaceTargetDependency,
            AllDependencies.Kits.lottieAnimationConfigurableKit,
            AllDependencies.Kits.onboardingManager,
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.Kits.commonKit,
            AllDependencies.ModuleInterfaces.loginModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.registerModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.mainTabBarModuleInterfaceTargetDependency
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.onboardingModuleInterfaceTarget
    ])
    return targets
}
let project = Project.makeTarget(
    name: "OnboardingModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets()
)
