import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
//    dependencies.append(contentsOf: AllDependencies.XCFrameworks.firebaseFirestoreDepedencies)
//    dependencies.append(contentsOf: AllDependencies.XCFrameworks.firebaseAuthDependencies)
    dependencies.append(contentsOf: [
        .external(name: ExternalSwiftPackageManager.firebaseAuth.description),
        .external(name: ExternalSwiftPackageManager.firebaseFirestore.description),
        AllDependencies.Kits.imageUploaderKit,
        AllDependencies.Kits.commonKit
    ])
    return dependencies
}
let project = Project.makeTarget(
    name: "UserManagerKit",
    hasResources: false,
    dependencies: makeDependencies()
)
