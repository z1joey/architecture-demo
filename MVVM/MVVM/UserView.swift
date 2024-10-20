import SwiftUI
import CoolDesign

struct UserView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var userName: String?
    @State private var userBio: String?

    var body: some View {
        VStack(alignment: .center) {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120, height: 120)

            Text(userName ?? "userName")
                .bold()
                .font(.title)

            Text(userBio ?? "userBio")
                .bold()
                .font(.title2)

            CoolButton(
                title: .constant("Retry"),
                isLoading: $viewModel.isLoading,
                action: viewModel.request
            )

            Spacer(minLength: 40)

            CoolButton(
                title: .constant("Root"),
                isLoading: .constant(false),
                action: viewModel.showRootView!
            )

            Spacer()
        }
        .onReceive(viewModel.$gitHubUser) {
            userName = $0?.login
            userBio = $0?.bio
        }
        .onAppear {
            AnalyticsManager.log(event: UserEvent.screenViewed())
        }
    }
}

import Combine

extension UserView {
    class ViewModel: ObservableObject {
        private let user: String
        private let userProvider: GitHubUserProviderProtocol

        @Published var isLoading: Bool = false
        @Published var gitHubUser: GitHubUser?

        var showRootView: (() -> Void)?

        init(
            user: String,
            userProvider: GitHubUserProviderProtocol,
            showRootView: ( () -> Void)? = nil)
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

// MARK: Mock
import DataAccess

struct StubGitHubUserProvider: GitHubUserProviderProtocol {
    func fetch(user: String) async throws -> GitHubUser {
        return .init(login: "login", avatarUrl: "avatar", bio: "bio")
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(
            viewModel:.init(
                user: "user",
                userProvider: StubGitHubUserProvider()
            )
        )
    }
}

import Analytics

private struct UserEvent: AnalyticsEvent {
    var name: String
    var meta: [String : String]

    static func screenViewed() -> UserEvent {
        .init(name: "User Viewed", meta: [:])
    }
}
