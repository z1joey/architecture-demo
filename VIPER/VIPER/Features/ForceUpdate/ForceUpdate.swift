import SwiftUI

struct ForceUpdate: View {
    @EnvironmentObject var presenter: RootView.Presenter

    var body: some View {
        VStack(spacing: 20) {
            Text("Oops, update needed.")
            Button("Try Deeplink") {
                presenter.testDeeplink()
            }
        }
    }
}

struct ForceUpdate_Previews: PreviewProvider {
    static var previews: some View {
        ForceUpdate()
    }
}
