import Combine

struct AppBuilder {
    let systemEventsHandler: SystemEventsHandling
    let appState: CurrentValueSubject<AppState, Never>
}

extension AppBuilder {
    static func build() -> Self {
        let systemEventsHandler = SystemEventsHandler()
        let appState = CurrentValueSubject<AppState, Never>(AppState())

        return AppBuilder(
            systemEventsHandler: systemEventsHandler,
            appState: appState
        )
    }
}
