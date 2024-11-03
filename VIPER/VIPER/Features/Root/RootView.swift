import SwiftUI
import Combine

struct RootView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @EnvironmentObject var sceneDelegate: SceneDelegate
    @StateObject var appState: AppState = AppState()

    @State private var selectedTab: Int = 0
    @State private var destination: Destination = .success

    private let deepLink: PassthroughSubject<URL, Never> = .init()
    private let interactor: RootInteractor

    init(interactor: RootInteractor) {
        self.interactor = interactor
        sceneDelegate.deepLinkDelegate = self.interactor
    }

//    init() {
//        DeeplinkWorkFlow(
//            userDidSignIn: appState.$hasUserSignIn.eraseToAnyPublisher(),
//            didReceiveDeeplink: deepLink.eraseToAnyPublisher()
//        )
//        .commit()
//    }

    var body: some View {
        Group {
            TabView(selection: $selectedTab) {
                UserProfileBuilder()
                    .withRouter(appState)
                    .build()
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
        .overlay {
            if !appState.hasUserSignIn {
                SignInBuilder()
                    .withPath(destination.path.compactMap { $0 as? SignInDestination })
                    .withRouter(appState)
                    .build()
            }
        }
        //.environmentObject(appState)
        .onChange(of: selectedTab) { appState.setTab($0) }
        .onChange(of: destination, perform: { newValue in
            selectedTab = newValue.tab
        })
        .onReceive(appState.$selectedTab) { if selectedTab != $0 { selectedTab = $0 } }
        .onReceive(sceneDelegate.$systemEvent) { appState.setActive($0 == .sceneDidBecomeActive) }
        .onReceive(appDelegate.$didFinishLaunching) { print("didFinishWithOptions: \($0?.options ?? [:])") }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(interactor: RootInteractor())
    }
}

private extension RootView {
    enum Destination {
        var tab: Int {
            switch self {
            case .success: return 0
            case .idle: return 0
            }
        }

        var path: [any Hashable] {
            switch self {
            case .success:
                return [SignInDestination.success]
            case .idle:
                return []
            }
        }

        case idle, success
    }
}
