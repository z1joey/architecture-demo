import Foundation

enum DeepLink: Equatable {
    case showUserName(_ userName: String)

    init?(url: URL) {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            components.host == "www.example.com",
            let query = components.queryItems
            else { return nil }
        if let item = query.first(where: { $0.name == "alpha3code" }),
            let userName = item.value {
            self = .showUserName(userName)
            return
        }
        return nil
    }
}

