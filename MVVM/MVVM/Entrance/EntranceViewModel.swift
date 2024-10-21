import Combine

extension EntranceView {
    class ViewModel: ObservableObject {
        @Published var userName: String = ""

        var showUserView: ((String) -> Void)?

        init(showUserView: ((String) -> Void)? = nil) {
            self.showUserView = showUserView
        }

        func showUser() {
            showUserView?(userName)
        }
    }
}
