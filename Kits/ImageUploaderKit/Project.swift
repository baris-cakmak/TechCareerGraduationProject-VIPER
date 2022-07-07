import ProjectDescription
import ProjectDescriptionHelpers

private func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []
//    dependencies.append(contentsOf: AllDependencies.XCFrameworks.firebaseStorageDependencies)
    dependencies.append(contentsOf: [
        .external(name: ExternalSwiftPackageManager.firebaseStorage.description)
    ])
    return dependencies
}
let project = Project.makeTarget(
    name: "ImageUploaderKit",
    hasResources: false,
    dependencies: makeDependencies()
)
