import Combine

class BaseInteractor: ObservableObject {
    @Injected(\.appState) var appState: AppStateSubject

    var colorScheme: any ColorScheme {
        appState.value.user.color
    }

    var cancelBag = CancelBag()
}

