import UIKit

protocol SystemEventsHandling {
    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>)
    func sceneDidBecomeActive()
    func sceneWillResignActive()
    func handlePushRegistration(result: Result<Data, Error>)
    func appDidReceiveRemoteNotification(payload: [AnyHashable: Any], fetchCompletion: @escaping (UIBackgroundFetchResult) -> Void)
}

class SystemEventsHandler: SystemEventsHandling {
    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>) {
        print("sceneOpenURLContexts")
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
