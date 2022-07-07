import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(contentsOf: [
        AllDependencies.Kits.commonKit,
        AllDependencies.Kits.lottieAnimationConfigurableKit,
        AllDependencies.Kits.userManager,
        AllDependencies.Kits.dependencyManagerKit,
        AllDependencies.Kits.signInValidatorKit,
        AllDependencies.ModuleInterfaces.loginModuleInterfaceTargetDependency,
        AllDependencies.ModuleInterfaces.registerModuleInterfaceTargetDependency,
        AllDependencies.ModuleInterfaces.mainTabBarModuleInterfaceTargetDependency
    ])
    return dependencies
}

private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.loginModuleInterfaceTarget
    ])
    return targets
}

let project = Project.makeTarget(
    name: "LoginModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets()
)
