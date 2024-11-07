import Combine

struct AppContext {
    let appState: AppStateSubject
    let systemEventsHandler: SystemEventsHandling
}

extension AppContext {
    static func instance() -> Self {
        let appState = AppStateSubject(AppState())
        let systemEventsHandler = SystemEventsHandler()

        return AppContext(
            appState: appState,
            systemEventsHandler: systemEventsHandler
        )
    }
}
