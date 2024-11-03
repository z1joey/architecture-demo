import SwiftUI

struct SignInView: View {
    @EnvironmentObject var presenter: SignInPresenter

    var body: some View {
        Button("Sign In") { presenter.signInTapped() }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
