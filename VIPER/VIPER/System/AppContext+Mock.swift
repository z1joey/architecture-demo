import Combine

extension AppContext {
    static func mock() -> Self {
        let appState = AppStateSubject(AppState())
        let systemEventsHandler = SystemEventsHandler(appState: appState)
        let interactors = FakeInteractors()
        return AppContext(
            appState: appState,
            interactors: interactors,
            systemEventsHandler: systemEventsHandler
        )
    }
}

class FakeInteractors: InteractorSet {
    lazy var signIn: SignIn.Interactor = {
        return SignIn.Interactor(provider: FakeSignInProvider())
    }()
}

struct FakeSignInProvider: SignInProvider {
    func signIn() -> AnyPublisher<GitHubUser, Error> {
        Just(GitHubUser(login: "", avatarUrl: "", bio: ""))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
