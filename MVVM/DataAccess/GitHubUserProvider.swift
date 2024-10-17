import Foundation

public protocol GitHubUserProviderProtocol {
    func fetch(user: String) async throws -> GitHubUser
}

public struct GitHubUserProvider: GitHubUserProviderProtocol {

    public init() {}

    public func fetch(user: String) async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/" + user

        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidEndpoint
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw GitHubError.invalidResponse(code: nil)
        }

        guard response.statusCode == 200 else {
            throw GitHubError.invalidResponse(code: response.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GitHubError.invalidData
        }
    }
}
