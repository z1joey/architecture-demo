import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
    @Published var systemEvent: SystemEvent = .idle

    @MainActor
    func sceneDidBecomeActive(_ scene: UIScene) {
        systemEvent = .sceneDidBecomeActive
        systemEvent = .idle
    }

    @MainActor
    func sceneWillResignActive(_ scene: UIScene) {
        systemEvent = .sceneWillResignActive
        systemEvent = .idle
    }
}
