import DataAccess

struct StubGitHubUserProvider: GitHubUserProviderProtocol {
    func fetch(user: String) async throws -> GitHubUser {
        return .init(login: "login", avatarUrl: "avatar", bio: "bio")
    }
}
