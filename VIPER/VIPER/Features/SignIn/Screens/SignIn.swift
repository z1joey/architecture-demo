import SwiftUI

struct SignIn: View {
    @ObservedObject var presenter: SignIn.Presenter
    @State var success: Bool = false

    var body: some View {
        VStack {
            Button("Sign In") {
                presenter.signInTapped()
            }

            if success {
                presenter.successView()
            }
        }
        .onReceive(presenter.result) { success = $0 }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(presenter: .init(interactor: SignInInteractor(), appState: .init(AppState())))
    }
}
