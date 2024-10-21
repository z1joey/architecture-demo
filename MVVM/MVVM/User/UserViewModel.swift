import Combine
import DataAccess

extension UserView {
    class ViewModel: ObservableObject {
        @Published var isLoading: Bool = false
        @Published var gitHubUser: GitHubUser?

        let user: String
        var showRootView: (() -> Void)?

        private let userProvider: GitHubUserProviderProtocol

        init(
            user: String,
            userProvider: GitHubUserProviderProtocol,
            showRootView: (() -> Void)? = nil)
        {
            self.user = user
            self.userProvider = userProvider
            self.showRootView = showRootView
        }

        func request() {
            isLoading = true

            Task { @MainActor in
                do {
                    gitHubUser = try await userProvider.fetch(user: user)
                    isLoading = false
                } catch {
                    isLoading = false
                }
            }
        }
    }
}
