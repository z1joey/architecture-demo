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
