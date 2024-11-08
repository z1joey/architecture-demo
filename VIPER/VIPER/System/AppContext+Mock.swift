extension AppContext {
    static func mock() -> Self {
        let appState = AppStateSubject(AppState())
        let systemEventsHandler = SystemEventsHandler(appState: appState)
        let interactors = configuredMockInteractors()
        return AppContext(
            appState: appState,
            interactors: interactors,
            systemEventsHandler: systemEventsHandler
        )
    }

    static func configuredMockInteractors() -> Interactors {
        return Interactors(
            signIn: SignIn.Interactor(provider: FakeSignInProvider())
        )
    }
}
