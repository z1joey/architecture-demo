import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let apiBaseURL = "API_BASE_URL"
            static let apiKey = "API_KEY"
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
            fatalError("Root URL not set in plist for this environment")
        }

        return url
    }()

    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
}
