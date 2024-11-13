import SwiftUI

class BaseInteractor: ObservableObject {
    @Injected(\.appState) var appState: AppStateSubject

    var cancelBag = CancelBag()
}

