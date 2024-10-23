import SwiftUI
import DataAccess
import Analytics

struct ContentView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @EnvironmentObject var sceneDelegate: SceneDelegate
    @ObservedObject var coordinator: Coordinator
    var deeplinkHandler: DeeplinkHandlerProtocol

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            EntranceView(viewModel: .init(
                deeplinks: DeeplinkProvider.allCases,
                showUserView: coordinator.showUser(_:)
            ))
            .navigationDestination(for: Destination.self) { screen in
                switch screen {
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
            .onOpenURL { deeplinkHandler.open(deeplink: AnyDeeplink(url: $0)) }
            .onReceive(appDelegate.$hasLaunched) { hasLaunched in
                print("hasLaunched : \(hasLaunched)")
                AnalyticsManager.auth()
            }
            .onReceive(sceneDelegate.$isActive) { isActive in
                print("isActive : \(isActive)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let coordinator: Coordinator = .init()

    static var previews: some View {
        ContentView(
            coordinator: coordinator,
            deeplinkHandler: DeeplinkHandler(coordinator: coordinator)
        )
    }
}
