import SwiftUI

class SignInBuilder: Buildable{
    var path: NavigationPath = .init()
    var router: SignInRouting?

    func build() -> some View {
        guard let router else {
            fatalError("invalid router")
        }

        let presenter = SignInPresenter(
            router: router,
            interactor: SignInInteractor(),
            path: path
        )

        return SignInNavigationView(presenter: presenter)
    }
}

private struct SignInNavigationView: View {
    @StateObject var presenter: SignInPresenter

    var body: some View {
        NavigationStack(path: $presenter.path) {
            TermsView()
                .environmentObject(presenter)
                .navigationDestination(for: SignInDestination.self) { dest in
                    switch dest {
                    case .success: SuccessView().environmentObject(presenter)
                    case .signIn: SignInView().environmentObject(presenter)
                    }
                }
        }
    }
}

struct SignInNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SignInNavigationView(presenter: .init(
            router: AppState(),
            interactor: SignInInteractor()
        ))
    }
}

