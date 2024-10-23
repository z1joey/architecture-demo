import SwiftUI

@main
struct MVVMApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let coordinator: Coordinator = .init()

    var body: some Scene {
        WindowGroup {
            ContentView(
                coordinator: coordinator,
                deeplinkHandler: DeeplinkHandler(coordinator: coordinator)
            )
        }
    }
}
