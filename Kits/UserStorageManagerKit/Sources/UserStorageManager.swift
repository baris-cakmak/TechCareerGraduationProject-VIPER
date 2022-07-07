import Foundation

enum UserStorageKey: String {
    case username
}
public protocol UserStorageManagerable {
    func setUserEmailForMealAPI(username: String)
    func getUserEmailForMealAPI() -> String
}

public final class UserStorageManager: UserStorageManagerable {
    public static let shared = UserStorageManager()
    private init() {}
    public func setUserEmailForMealAPI(username: String) {
        UserDefaults.standard.set(username, forKey: UserStorageKey.username.rawValue)
    }
    public func getUserEmailForMealAPI() -> String {
        UserDefaults.standard.string(forKey: UserStorageKey.username.rawValue) ?? ""
    }
}
