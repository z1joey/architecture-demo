import Combine
import Foundation

class AppState: ObservableObject {
    @Published private(set) var hasUserSignIn: Bool = false
    @Published private(set) var isActive: Bool = false
    @Published private(set) var selectedTab: Int = 0
    @Published private(set) var error: Error?

    func setSignIn(_ success: Bool) {
        if success, !hasUserSignIn {
            hasUserSignIn = success
        } else {
            hasUserSignIn = false
            selectedTab = 0
        }
    }

    func setActive(_ isActive: Bool) {
        if self.isActive != isActive {
            self.isActive = isActive
        }
    }

    func setTab(_ tab: Int) {
        if selectedTab != tab {
            selectedTab = tab
        }
    }

    func setError(_ error: Error) {
        self.error = error
    }
}
