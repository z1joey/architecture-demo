public struct GitHubUser: Codable {
    public let login: String
    public let avatarUrl: String
    public let bio: String

    public init(login: String, avatarUrl: String, bio: String) {
        self.login = login
        self.avatarUrl = avatarUrl
        self.bio = bio
    }
}
