import SwiftUI
import Combine

protocol RootDependency {
    var appState: AppStateSubject { get }
}

extension AppContext: RootDependency {}

extension RootView {
    class Presenter: ObservableObject {
        private let dependency: RootDependency
        private var cancelBag = CancelBag()

        @Published var router: Routing

        init(dependency: RootDependency) {
            self.dependency = dependency
            _router = .init(initialValue: dependency.appState.value.routing.root)

            $router
                .sink { dependency.appState[\.routing.root] = $0 }
                .store(in: &cancelBag)

            dependency
                .appState.map(\.routing.root)
                .weaklyAssign(to: self, \.router)
                .store(in: &cancelBag)
        }

        func signInView() -> some View {
            SignIn(presenter: .init(
                interactor: SignInInteractor(),
                appState: dependency.appState
            ))
        }
    }
}
