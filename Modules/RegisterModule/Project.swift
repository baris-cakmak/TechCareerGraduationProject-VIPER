import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
    dependencies.append(
        contentsOf: [
            AllDependencies.Kits.userManager,
            AllDependencies.Kits.signUpValidatorKit,
            AllDependencies.Kits.dependencyManagerKit,
            AllDependencies.Kits.lottieAnimationConfigurableKit,
            AllDependencies.ModuleInterfaces.registerModuleInterfaceTargetDependency
        ]
    )
    return dependencies
}
private func makeTargets() -> [Target] {
    var targets: [Target] = []
    targets.append(contentsOf: [
        AllDependencies.ModuleInterfaces.registerModuleInterfaceTarget,
    ])
    return targets
}
let project = Project.makeTarget(
    name: "RegisterModule",
    hasResources: true,
    dependencies: makeDependencies(),
    hasUnitTest: true,
    hasUITest: true,
    targets: makeTargets()
)
