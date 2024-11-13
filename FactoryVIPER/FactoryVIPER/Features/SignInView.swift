import SwiftUI

struct SignInView: View {
    @ObservedObject var interactor: Interactor

    init(interactor: Interactor = Interactor()) {
        self.interactor = interactor
    }

    var body: some View {
        Button {
            interactor.signInTapped()
        } label: {
            Text("Sign In")
        }

    }
}

#Preview {
    SignInView()
}

extension SignInView {
    struct Routing: Equatable {}
}

extension SignInView {
    class Interactor: ObservableObject {
        @Injected(\.appState) var appState: AppStateSubject
        @Published var routing: Routing = .init()

        private var cancelBag = CancelBag()

        init() {
            _routing = .init(initialValue: appState.value.routing.signIn)
            routeBinding()
        }

        func signInTapped() {
            
        }
    }
}

private extension SignInView.Interactor {
    func routeBinding() {
        $routing
            .sink { [weak appState] value in
                guard let appState else { return }
                appState[\.routing.signIn] = value
            }
            .store(in: &cancelBag)

        appState.map(\.routing.signIn)
            .weaklyAssign(to: self, \.routing)
            .store(in: &cancelBag)
    }
}
