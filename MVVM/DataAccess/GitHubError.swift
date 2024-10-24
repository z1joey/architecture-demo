public enum GitHubError: Error {
    case invalidEndpoint
    case invalidResponse(code: Int?)
    case invalidData
}
