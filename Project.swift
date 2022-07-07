import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

func makeDependencies() -> [TargetDependency] {
    var dependencies: [TargetDependency] = []

    dependencies.append(contentsOf: [
        .external(name: ExternalSwiftPackageManager.firebaseAuth.description),
        .external(name: ExternalSwiftPackageManager.firebaseFirestore.description),
        .external(name: ExternalSwiftPackageManager.firebaseStorage.description),
        .external(name: ExternalSwiftPackageManager.firebaseAnalytics.description)
    ])
    dependencies.append(contentsOf: [
        AllDependencies.Modules.rootModule,
        AllDependencies.Modules.loginModule,
        AllDependencies.Modules.onboardingModule,
        AllDependencies.Modules.mainTabBarModule,
        AllDependencies.Modules.homeDetailModule,
        AllDependencies.Modules.homeModule,
        AllDependencies.Modules.profileModule,
        AllDependencies.Modules.registerModule,
        AllDependencies.Modules.cartModule,
        AllDependencies.Modules.restaurantModule,
        
        AllDependencies.Kits.dependencyManagerKit,
        AllDependencies.Kits.onboardingManager,
        AllDependencies.Kits.userStorageManager,
        AllDependencies.Kits.signInValidatorKit,
        AllDependencies.Kits.signUpValidatorKit,
        AllDependencies.Kits.mealsAPI,
        AllDependencies.Kits.dummyRestaurantApiKit,
        AllDependencies.Kits.imageUploaderKit,
        AllDependencies.Kits.baseKit
    ])
    return dependencies
}

// MARK: - Settings
let configurations: [Configuration] = [
    .debug(name: "Debug", xcconfig: .relativeToRoot(PathConstants.configPath.appending("TechGraduationProjectTarget.xcconfig"))),
    .release(name: "Release", xcconfig: .relativeToRoot(PathConstants.configPath.appending("TechGraduationProjectTarget.xcconfig")))
]
let settings: Settings = .settings(configurations: configurations)

// MARK: - Project
private let swiftlint = """
  export PATH="$PATH:/opt/homebrew/bin"
  if which swiftlint > /dev/null; then
    swiftlint --config .swiftlint.yml
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
  """
let appTarget = Target(
    name: "TechCareerGraduationProject",
    platform: .iOS,
    product: .app,
    bundleId: "com.bariscakmak.TechCareerGraduationProject",
    infoPlist: "MyTechCareerGraduationProjectInfo.plist",
    sources: "Sources/**",
    resources: "Resources/**",
    scripts: [
        .pre(script: swiftlint, name: "Run Swiftlint")
    ],
    dependencies: makeDependencies(),
    settings: settings
)

let uiTestTarget = Target(
    name: "TechCareerGraduationProjectUITests",
    platform: .iOS,
    product: .uiTests,
    bundleId: "com.bariscakmak.TechCareerGraduationProject",
    infoPlist: .default,
    sources: "UITests/**",
    dependencies: [
        .target(name: "TechCareerGraduationProject")
    ]
)
let project = Project(name: "TechCareerGraduationProject", options: .options(automaticSchemesOptions: .enabled(targetSchemesGrouping: .singleScheme, codeCoverageEnabled: true, testingOptions: .parallelizable), developmentRegion: nil, disableBundleAccessors: false, disableShowEnvironmentVarsInScriptPhases: false, disableSynthesizedResourceAccessors: false, textSettings: .textSettings(), xcodeProjectName: nil), targets: [appTarget, uiTestTarget])

