import SwiftUI
import Combine

extension RootView {
    class Presenter: ObservableObject, Presentable {
        let context: AppContext
        private var cancelBag = CancelBag()

        @Published var router: Routing

        init(context: AppContext) {
            self.context = context

            _router = .init(initialValue: context.appState.value.routing.root)

            $router
                .sink { context.appState[\.routing.root] = $0 }
                .store(in: &cancelBag)

            appState.map(\.routing.root)
                .weaklyAssign(to: self, \.router)
                .store(in: &cancelBag)
        }

        func signInView() -> some View {
            SignIn(presenter: .init(context: context))
        }

        func testDeeplink() {
            appState[\.routing.root.forceUpdateSheet] = false
            UIApplication.shared.open(URL(string: "viper://user/test")!)
        }

        func didDismissDebugMenu() {
            appState[\.routing.root.debugMenuSheet] = false
        }
    }
}
