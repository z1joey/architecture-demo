import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let apiBaseURL = "API_BASE_URL"
            static let apiKey = "API_KEY"
            static let deeplinkBaseURL = "DEEPLINK_BASE_URL"
        }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let apiBaseURL: String = {
        guard let url = Environment.infoDictionary[Keys.Plist.apiBaseURL] as? String else {
            fatalError("API base url not set in plist for this environment")
        }

        return url
    }()

    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()

    static let deeplinkBaseURL: String = {
        guard let url = Environment.infoDictionary[Keys.Plist.deeplinkBaseURL] as? String else {
            fatalError("Deeplink base url not set in plist for this environment")
        }

        return url
    }()
}
