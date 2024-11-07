import SwiftUI
import Combine

struct RootView: View {
    @State private var selectedTab: Int = 0
    private let presenter: RootView.Presenter

    init(presenter: RootView.Presenter) {
        self.presenter = presenter
    }

    var body: some View {
        Group {
            presenter.signInView()
//            TabView(selection: $selectedTab) {
//                Text("One")
//                    .tabItem {
//                        Label("One", systemImage: "star")
//                    }
//                    .tag(0)
//
//                Text("Two")
//                    .tabItem {
//                        Label("Two", systemImage: "circle")
//                    }
//                    .tag(1)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        SignIn(presenter: .init(interactor: SignInInteractor(), appState: .init(AppState())))
    }
}

extension RootView {
    struct Routing: Equatable {
        var tab: Int = 0
        var signInSheet: Bool = true
    }
}
