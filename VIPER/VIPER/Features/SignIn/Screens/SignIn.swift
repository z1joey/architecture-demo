import SwiftUI

struct SignIn: View {
    @EnvironmentObject var interactor: SignIn.Interactor

    var body: some View {
        Button("Sign In") {
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
