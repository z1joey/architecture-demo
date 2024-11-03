// MARK: App level routing
protocol SignInRouting {
    func showUserProfile()
    func show2ndTab()
}

extension AppState: SignInRouting {
    func showUserProfile() {
        setSignIn(true)
    }

    func show2ndTab() {
        setTab(1)
    }
}

// MARK: Module level routing
enum SignInDestination: Hashable {
    case signIn
    case success
}

