import SwiftUI
import Combine

struct RootView: View {
    @State private var selectedTab: Int = 0
    private var tabBinding: Binding<Int> {
        $selectedTab.share(with: appState, \.routing.root.tab)
    }

    private let appState: AppStateSubject

    init(appState: AppStateSubject) {
        self.appState = appState
    }

    var body: some View {
        Group {
            TabView(selection: tabBinding) {
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
        }
        .environment(\.appState, appState)
        .onReceive(appState.get(\.routing.root.tab)) { selectedTab = $0 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(appState: .init(AppState()))
    }
}

extension RootView {
    struct Routing: Equatable {
        var tab: Int = 0
        var signInSheet: Bool = true
    }
}
