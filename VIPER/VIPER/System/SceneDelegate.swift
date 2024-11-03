import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
    @Published var systemEvent: SystemEvent?
    weak var deepLinkDelegate: DeepLinkDelegate?

    @MainActor
    func sceneDidBecomeActive(_ scene: UIScene) {
        systemEvent = .sceneDidBecomeActive
    }

    @MainActor
    func sceneWillResignActive(_ scene: UIScene) {
        systemEvent = .sceneWillResignActive
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        deepLinkDelegate?.open(url)
    }
}

protocol DeepLinkDelegate: AnyObject {
    func open(_ url: URL)
}
