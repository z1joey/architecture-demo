import Combine

extension HomeView {
    class Interactor: BaseInteractor {
        var user: AnyPublisher<GitHubUser, Never> {
            appState.get(\.user.user).compactMap { $0 }.eraseToAnyPublisher()
        }

        func changeSchemeTapped() {
            if colorScheme is DefaultColorScheme {
                appState.value.user.color = NewMoneyScheme()
            } else {
                appState.value.user.color = DefaultColorScheme()
            }
        }
    }
}
