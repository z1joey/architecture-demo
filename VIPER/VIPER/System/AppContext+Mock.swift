import Combine

extension AppContext {
    static func mock() -> Self {
        let appState = AppStateSubject(AppState())
        let systemEventsHandler = SystemEventsHandler(appState: appState)
        return AppContext(
            appState: appState,
            dataAccess: FakeDataAccess(),
            systemEventsHandler: systemEventsHandler
        )
    }
}

class FakeDataAccess: DataAccess {
    lazy var signInProvider: SignInProvider = FakeSignInProvider()
}

struct FakeSignInProvider: SignInProvider {
    func signIn() -> AnyPublisher<GitHubUser, Error> {
        Just(GitHubUser(login: "", avatarUrl: "", bio: ""))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
