import SwiftUI
import Combine

extension SignIn {
    class Presenter: ObservableObject {
        private let interactor: SignInInteractor
        private let appState: AppStateSubject
        private var cancelBag = CancelBag()

        @Published var router: Routing
        @Published var isLoading: Bool = false

        init(interactor: SignInInteractor, appState: AppStateSubject) {
            _router = .init(initialValue: appState.value.routing.signIn)

            self.interactor = interactor
            self.appState = appState

            $router
                .sink { appState[\.routing.signIn] = $0 }
                .store(in: &cancelBag)

            appState.map(\.routing.signIn)
                .weaklyAssign(to: self, \.router)
                .store(in: &cancelBag)
        }

        func signInTapped() {
            isLoading = true

            interactor.signIn()
                .combineLatest(appState
                    .get(\.system.unhandledDeeplinks)
                    .setFailureType(to: Error.self)
                )
                .sink(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                }, receiveValue: { [unowned appState] token, urls in
                    appState[\.user.token] = token
                    if urls.isEmpty {
                        print("continue to success")
                        appState.set {
                            $0.user.token = token
                            $0.routing.signIn.path.append(Destination.success)
                        }
                    } else {
                        print("deeplink takeover next")
                    }
                })
                .store(in: &cancelBag)
        }

        func goToHomeTapped() {
            appState.set {
                $0.routing.root.tab = 1
                $0.routing.root.signInSheet = false
            }
        }
    }
}

extension SignIn.Presenter {
    func successView() -> some View {
        Success().environmentObject(self)
    }

    @ViewBuilder
    func tokenView() -> some View {
        if let token = appState.value.user.token {
            Text(token)
        }
    }
}
