import UIKit
import Combine

protocol SystemEventsHandling {
    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>)
    func sceneDidBecomeActive()
    func sceneWillResignActive()
    func handlePushRegistration(result: Result<Data, Error>)
    func appDidReceiveRemoteNotification(payload: [AnyHashable: Any], fetchCompletion: @escaping (UIBackgroundFetchResult) -> Void)
}

class SystemEventsHandler: SystemEventsHandling {
    private let appState: AppStateSubject
    private var cancelBag = CancelBag()

    init(appState: AppStateSubject) {
        self.appState = appState

        Publishers
            .CombineLatest(
                appState.get(\.user.token).compactMap { $0 },
                appState.get(\.system.unhandledDeeplinks).filter { !$0.isEmpty }
            )
            .sink { (_, urls) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    appState.set {
                        //$0.routing.root.tab = 1
                        //$0.routing.root.signInSheet = false
                        $0.system.unhandledDeeplinks.removeAll()
                    }
                    print("deeplink handled")
                }
            }
            .store(in: &cancelBag)
    }

    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>) {
        print("sceneOpenURLContexts")
        guard let url = urlContexts.first?.url else { return }

        appState[\.system.unhandledDeeplinks].insert(url)
    }

    func sceneDidBecomeActive() {
        print("sceneDidBecomeActive")
    }
    
    func sceneWillResignActive() {
        print("sceneWillResignActive")
    }
    
    func handlePushRegistration(result: Result<Data, Error>) {
        print("handlePushRegistration")
    }

    func appDidReceiveRemoteNotification(payload: [AnyHashable : Any], fetchCompletion: @escaping (UIBackgroundFetchResult) -> Void) {
        print("appDidReceiveRemoteNotification")
    }
}
