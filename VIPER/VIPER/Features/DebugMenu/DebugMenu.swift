import SwiftUI

struct DebugMenu: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("BUNDLE_ID: \(Bundle.main.bundleIdentifier ?? "NULL")")
                Text("API_KEY: \(Environment.apiKey)")
                Text("BASE_URL: \(Environment.apiBaseURL)")
                NavigationLink("UIShowcases") {
                    Text("Go to screen 2")
                }
            }
            .backgroundStyle(.cyan)
        }
    }
}

struct DebugMenu_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenu()
    }
}
