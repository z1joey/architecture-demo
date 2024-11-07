struct AppState: Equatable {
    var user = UserData()
    var system = System()
    var routing = ViewRouting()
}

extension AppState {
    struct UserData: Equatable {
        var token: String?
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var signIn = SignIn.Routing()
        var root = RootView.Routing()
    }
}

import SwiftUI
import Combine

typealias AppStateSubject = CurrentValueSubject<AppState, Never>

struct AppStateKey: EnvironmentKey {
    static var defaultValue: AppStateSubject = .init(AppState())
}

extension EnvironmentValues {
    var appState: AppStateSubject {
        get { self[AppStateKey.self] }
        set { self[AppStateKey.self] = newValue }
    }
}
