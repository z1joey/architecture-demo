extension Container {
    var appState: Factory<AppStateSubject> {
        self { AppStateSubject(AppState()) }.singleton
    }
}

