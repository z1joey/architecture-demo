import SwiftUI

extension RootView {
    class Interactor: BaseInteractor {
        @Published var routing: Routing = .init()

        override init() {
            super.init()
            _routing = .init(initialValue: appState.value.routing.root)
            routeBinding()
        }
    }
}

private extension RootView.Interactor {
    func routeBinding() {
        $routing
            .sink { [weak appState] value in
                guard let appState else { return }
                appState[\.routing.root] = value
            }
            .store(in: &cancelBag)

        appState.map(\.routing.root)
            .weaklyAssign(to: self, \.routing)
            .store(in: &cancelBag)
    }
}

