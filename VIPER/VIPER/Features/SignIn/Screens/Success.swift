import SwiftUI

struct Success: View {
    @EnvironmentObject var presenter: SignIn.Presenter

    var body: some View {
        VStack(spacing: 20) {
            Text("Success!")
            Button("Back to Terms") {
            }
            Button("User has signed in") {
            }
            Button("SignIn and Show 2nd Tab") {
            }
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        Success()
    }
}
