protocol Presentable {
    var context: AppContext { get }
}

extension Presentable {
    var appState: AppStateSubject {
        context.appState
    }

    var dataAccess: DataAccess {
        context.dataAccess
    }
}
