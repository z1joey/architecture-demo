import SwiftUI
import DataAccess

struct ContentView: View {
    @ObservedObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            EntranceView(viewModel: .init {
                coordinator.showUser($0)
            })
            .navigationDestination(for: NavigationDestinations.self) { screen in
                switch screen {
                case .Entrance:
                    EntranceView(viewModel: .init {
                        coordinator.showUser($0)
                    })
                case .User(let id):
                    UserView(viewModel: .init(
                        user: id,
                        userProvider: GitHubUserProvider(),
                        showRootView: coordinator.showRoot,
                        showError: coordinator.showError(_:)
                    ))
                }
            }
            .alert("Error", isPresented: .constant(coordinator.error != nil), actions: {
                Button("Dismiss") {
                    coordinator.error = nil
                }
            }, message: {
                Text(coordinator.error?.localizedDescription ?? "No description")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: .init())
    }
}
