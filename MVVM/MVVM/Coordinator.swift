import SwiftUI

extension ContentView {
    class Coordinator: ObservableObject {
        @Published var navigationPath = NavigationPath()
        @Published var error: Error?

        func showUser(_ user: String) {
            navigationPath.append(NavigationDestinations.User(id: user))
        }

        func showRoot() {
            navigationPath = .init()
        }

        func showError(_ error: Error) {
            self.error = error
        }
    }
}
