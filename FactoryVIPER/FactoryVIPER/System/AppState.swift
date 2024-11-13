import SwiftUI
import Combine

typealias AppStateSubject = CurrentValueSubject<AppState, Never>

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
        var unhandledDeeplinks: Set<URL> = []
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var signIn: SignInView.Routing = .init()
    }
}
