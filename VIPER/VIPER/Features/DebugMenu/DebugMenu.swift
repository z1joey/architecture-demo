import SwiftUI

struct DebugMenu: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("BUNDLE_ID: \(Bundle.main.bundleIdentifier ?? "NULL")")
                Text("API KEY: \(Environment.apiKey)")
                Text("API Base url: \(Environment.apiBaseURL)")
                Text("Deeplink url: \(Environment.deeplinkBaseURL)")
                NavigationLink("UIShowcases") {
                    Text("Go to screen 2")
                }
            }
        }
    }
}

struct DebugMenu_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenu()
    }
}
