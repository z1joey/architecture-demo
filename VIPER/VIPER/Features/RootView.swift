import SwiftUI
import Combine

struct RootView: View {
    @ObservedObject private var presenter: RootView.Presenter

    init(presenter: RootView.Presenter) {
        self.presenter = presenter
    }

    var body: some View {
        Group {
            TabView(selection: $presenter.router.tab) {
                Text("One")
                    .tabItem {
                        Label("One", systemImage: "star")
                    }
                    .tag(0)

                Text("Two")
                    .tabItem {
                        Label("Two", systemImage: "circle")
                    }
                    .tag(1)
            }
            .fullScreenCover(isPresented: $presenter.router.signInSheet) {
                presenter.signInView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        SignIn(presenter: .init(
            interactor: SignInInteractor(),
            appState: .init(AppState())
        ))
    }
}
