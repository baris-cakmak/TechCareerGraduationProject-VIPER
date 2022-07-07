import ProjectDescription
import ProjectDescriptionHelpers

func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(
        contentsOf: [
            AllDependencies.Kits.userManager,
            AllDependencies.Kits.lottieAnimationConfigurableKit,
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.Kits.commonKit,
            .external(name: ExternalSwiftPackageManager.sDWebImage.description),
            AllDependencies.ModuleInterfaces.profileModuleInterfaceTargetDependency,
            AllDependencies.ModuleInterfaces.loginModuleInterfaceTargetDependency
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.profileModuleInterfaceTarget,
    ])
    return targets
}
let project = Project.makeTarget(
    name: "ProfileModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    targets: makeTargets()
)
