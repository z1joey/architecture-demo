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
            .sheet(isPresented: $presenter.router.debugMenuSheet, onDismiss: {
                presenter.didDismissDebugMenu()
            }, content: {
                DebugMenu()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            })
            .fullScreenCover(isPresented: $presenter.router.forceUpdateSheet) {
                ForceUpdate().environmentObject(presenter)
            }
            .overlay {
                if presenter.router.signInSheet {
                    presenter.signInView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        RootView(presenter: .init(context: AppContext.mock()))
    }
}
