import SwiftUI

extension SignIn: Buildable {
    static func build() -> some View {
        return SignInNavigationView(interactor: .init())
    }
}

private struct SignInNavigationView: View {
    @StateObject var interactor: SignIn.Interactor

    var body: some View {
        NavigationStack() {
            SignIn().environmentObject(interactor)
        }
    }
}

struct SignInNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn.build()
    }
}

