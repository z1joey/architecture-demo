import SwiftUI

struct DebugMenu: View {
    var body: some View {
        NavigationStack {
            VStack {
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
