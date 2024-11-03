import SwiftUI

struct TermsView: View {
    @State private var step: Int? = 0
    @EnvironmentObject var presenter: SignInPresenter

    var body: some View {
        VStack(spacing: 20) {
            Text("Please read the terms&condition")
            Button("Continue") {
                presenter.continueTapped()
            }
        }
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
