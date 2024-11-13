import Combine

extension HomeView {
    class Interactor: BaseInteractor {
        var user: AnyPublisher<GitHubUser, Never> {
            appState.get(\.user.user).compactMap { $0 }.eraseToAnyPublisher()
        }
    }
}
