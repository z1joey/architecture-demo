import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    @Published var didFinishLaunching: (
        application: UIApplication,
        options: [UIApplication.LaunchOptionsKey : Any]?
    )?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        didFinishLaunching = (application, launchOptions)

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
