import Combine

extension SignInView {
    class Interactor: BaseInteractor {
        @Injected(\.signInProvider) var provider: SignInProvider

        func signInTapped() {
            provider.signIn()
                .sink { completion in
                    print(completion)
                } receiveValue: { [weak appState] user in
                    guard let appState else { return }
                    appState.set {
                        $0.user.user = user
                        $0.routing.root.signInSheet = false
                    }
                }
                .store(in: &cancelBag)
        }
    }
}
