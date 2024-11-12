import SwiftUI
import Combine

extension SignIn {
    class Presenter: ObservableObject, Presentable {
        let context: AppContext
        private var cancelBag = CancelBag()

        @Published var router: Routing
        @Published var isLoading: Bool = false

        init(context: AppContext) {
            _router = .init(initialValue: context.appState.value.routing.signIn)

            self.context = context

            $router
                .sink { context.appState[\.routing.signIn] = $0 }
                .store(in: &cancelBag)

            appState.map(\.routing.signIn)
                .weaklyAssign(to: self, \.router)
                .store(in: &cancelBag)
        }

        func signInTapped() {
            isLoading = true

            dataAccess.signInProvider
                .signIn().print()
                .combineLatest(context.appState
                    .get(\.system.unhandledDeeplinks)
                    .setFailureType(to: Error.self)
                )
                .sink(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                }, receiveValue: { [weak self] user, urls in
                    self?.context.appState[\.user.token] = user.login

                    if urls.isEmpty {
                        print("continue to success")
                        self?.context.appState[\.routing.signIn.path].append(Destination.success)
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
        if let token = context.appState.value.user.token {
            Text(token)
        }
    }
}
