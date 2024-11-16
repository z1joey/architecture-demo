import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var systemEventsHandler: RealSystemEventsHandler? = {
        self.systemEventsHandler(UIApplication.shared)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("connectingSceneSession")
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("performActionFor")
//        switch shortcutItem.type {
//        case "com.appsym.viper.debugMenu":
//            print("debug menu tapped")
//        default: break
//        }
//        completionHandler(true)
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
    func systemEventsHandler(_ application: UIApplication) -> RealSystemEventsHandler? {
        return sceneDelegate(application)?.systemEventsHandler
    }

    func sceneDelegate(_ application: UIApplication) -> SceneDelegate? {
        return application
            .connectedScenes
            .compactMap { $0.delegate as? SceneDelegate }
            .first
    }
}
