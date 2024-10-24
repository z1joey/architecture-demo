import DataAccess

let mockedUser = GitHubUser(login: "testLogin", avatarUrl: "testAvatarUrl", bio: "testBio")

struct MockedUserProvider: GitHubUserProviderProtocol {
    func fetch(user: String) async throws -> GitHubUser {
        return mockedUser
    }
}
