import SwiftUI

@main
struct MVVMApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(coordinator: .init())
        }
    }
}
