import SwiftUI

@main
struct VIPERApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootBuilder().build()
        }
    }
}
