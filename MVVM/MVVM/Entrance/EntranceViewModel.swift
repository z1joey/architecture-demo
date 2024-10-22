import Foundation
import Combine
import UIKit

extension EntranceView {
    class ViewModel: ObservableObject {
        @Published var userName: String = ""

        let deeplinks: [Deeplink]
        var showUserView: ((String) -> Void)?

        init(deeplinks: [Deeplink], showUserView: ((String) -> Void)? = nil) {
            self.deeplinks = deeplinks
            self.showUserView = showUserView
        }

        func showUser() {
            showUserView?(userName)
        }

        func open(deeplink: Deeplink) {
            UIApplication.shared.open(deeplink.url)
        }
    }
}
