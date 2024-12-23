import SwiftUI

struct SignIn: View {
    @ObservedObject var presenter: SignIn.Presenter

    var body: some View {
        NavigationStack(path: $presenter.router.path) {
            VStack {
                Button(presenter.isLoading ? tr("signing_in") : tr("sign_in")) {
                    presenter.signInTapped()
                }
                .disabled(presenter.isLoading)
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .success:
                    presenter.successView()
                }
            }
        }
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(presenter: .init(context: AppContext.mock()))
            .environment(\.locale, .init(identifier: "zh_CN"))
    }
}
#endif
