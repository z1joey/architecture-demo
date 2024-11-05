import UIKit

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    lazy var systemEventsHandler: SystemEventsHandling? = {
        self.systemEventsHandler(UIApplication.shared)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        systemEventsHandler?.handlePushRegistration(result: .success(deviceToken))
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        systemEventsHandler?.handlePushRegistration(result: .failure(error))
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        systemEventsHandler?
            .appDidReceiveRemoteNotification(payload: userInfo, fetchCompletion: completionHandler)
    }
}

private extension AppDelegate {
    func systemEventsHandler(_ application: UIApplication) -> SystemEventsHandling? {
        return sceneDelegate(application)?.systemEventsHandler
    }

    func sceneDelegate(_ application: UIApplication) -> SceneDelegate? {
        return application
            .connectedScenes
            .compactMap { $0.delegate as? SceneDelegate }
            .first
    }
}
