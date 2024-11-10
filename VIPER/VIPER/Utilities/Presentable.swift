protocol Presentable {
    var context: AppContext { get }
}

extension Presentable {
    var appState: AppStateSubject {
        context.appState
    }

    var interactors: AppContext.Interactors {
        context.interactors
    }
}