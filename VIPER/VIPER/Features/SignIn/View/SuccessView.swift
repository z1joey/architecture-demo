import SwiftUI

struct SuccessView: View {
    @EnvironmentObject var presenter: SignInPresenter

    var body: some View {
        VStack(spacing: 20) {
            Text("Success!")
            Button("Back to Terms") {
                presenter.backToTermsTapped()
            }
            Button("User has signed in") {
                presenter.userSignedIn()
            }
            Button("SignIn and Show 2nd Tab") {
                presenter.showSecondTab()
            }
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
