import Combine

struct AppContext {
    let appState: AppStateSubject
    let systemEventsHandler: SystemEventsHandling
}

extension AppContext {
    static func instance() -> Self {
        let appState = AppStateSubject(AppState())
        let systemEventsHandler = SystemEventsHandler(appState: appState)

        return AppContext(
            appState: appState,
            systemEventsHandler: systemEventsHandler
        )
    }
}
