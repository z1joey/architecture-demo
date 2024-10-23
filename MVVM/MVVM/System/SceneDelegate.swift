import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
    @Published var isActive: Bool = true

    @MainActor
    func sceneDidBecomeActive(_ scene: UIScene) {
        isActive = true
    }

    @MainActor
    func sceneWillResignActive(_ scene: UIScene) {
        isActive = false
    }
}
