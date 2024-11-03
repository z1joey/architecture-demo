protocol UserProfileRouting {
    func routeToSignIn()
}

extension AppState: UserProfileRouting {
    func routeToSignIn() {
        setSignIn(false)
    }
}
