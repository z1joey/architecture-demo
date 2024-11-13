import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var systemEventsHandler: RealSystemEventsHandler?

    private let appState: AppStateSubject = .init(AppState())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        addDebugShortcutIfNeeded()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let view = RootView()

            window.rootViewController = UIHostingController(rootView: view)
            window.makeKeyAndVisible()

            self.systemEventsHandler = Container.shared.systemEventHandler.resolve()
            self.window = window
        }

        if let shortcutItem = connectionOptions.shortcutItem,
           shortcutItem.type == "com.viper.debugMenu" {
            //appState[\.routing.root.debugMenuSheet] = true
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        systemEventsHandler?.sceneOpenURLContexts(URLContexts)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        systemEventsHandler?.sceneDidBecomeActive()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        systemEventsHandler?.sceneWillResignActive()
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.viper.debugMenu" {
            //appState[\.routing.root.debugMenuSheet] = true
            completionHandler(true)
        }
    }
}

private extension SceneDelegate {
    func addDebugShortcutIfNeeded() {
        #if DEBUG
        guard let shortcuts = UIApplication.shared.shortcutItems,
              shortcuts.isEmpty else {
            return
        }

        let debugMenu = UIApplicationShortcutItem(
            type: "com.viper.debugMenu",
            localizedTitle: "DebugMenu",
            localizedSubtitle: nil,
            icon: .init(systemImageName: "ant.circle")
        )

        UIApplication.shared.shortcutItems?.append(debugMenu)
        #endif
    }
}
