import SwiftUI
import Combine

extension SignIn {
    class Presenter: ObservableObject {
        private let interactor: SignInInteractorable
        private let appState: AppStateSubject

        var result: AnyPublisher<Bool, Never> {
            appState.get(\.routing.success.result)
        }

        init(interactor: SignInInteractorable, appState: AppStateSubject) {
            self.interactor = interactor
            self.appState = appState
        }

        func signInTapped() {
            _ = interactor.signIn()
                .sink(receiveCompletion: { comp in
                    print(comp)
                }, receiveValue: { result in
                    print(result)
                })
            appState.set {
                $0.routing.success.result.toggle()
            }
        }
    }
}

extension SignIn.Presenter {
    func successView() -> some View {
        Success().environmentObject(self)
    }
}
