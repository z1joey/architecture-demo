import SwiftUI

class Coordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var error: Error?
    
    func showUser(_ user: String) {
        navigationPath.append(Destination.User(id: user))
    }
    
    func showRoot() {
        navigationPath = .init()
    }
    
    func showError(_ error: Error) {
        self.error = error
    }
}
