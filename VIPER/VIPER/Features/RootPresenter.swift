import SwiftUI

protocol RootDependency {
    var appState: AppStateSubject { get }
}

extension AppContext: RootDependency {}

extension RootView {
    struct Presenter {
        private let dependency: RootDependency

        init(dependency: RootDependency) {
            self.dependency = dependency
        }

        func signInView() -> some View {
            SignIn(presenter: .init(
                interactor: SignInInteractor(),
                appState: dependency.appState
            ))
        }
    }
}
