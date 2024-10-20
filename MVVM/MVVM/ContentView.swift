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
                case .User:
                    UserView(viewModel: .init(
                        user: coordinator.user,
                        userProvider: GitHubUserProvider()
                    ) {
                        coordinator.showRoot()
                    })
                }
            }
        }
    }
}

// MARK: Architecuture
extension ContentView {
    class Coordinator: ObservableObject {
        @Published fileprivate var navigationPath = NavigationPath()
        fileprivate var user: String = ""

        func showUser(_ user: String) {
            self.user = user
            navigationPath.append(NavigationDestinations.User)
        }

        func showRoot() {
            navigationPath = .init()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: .init())
    }
}
