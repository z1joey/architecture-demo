import SwiftUI

struct Success: View {
    @EnvironmentObject var presenter: SignIn.Presenter

    var body: some View {
        VStack(spacing: 20) {
            presenter.tokenView()

            Button("Go to home") {
                presenter.goToHomeTapped()
            }
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        Success()
    }
}
