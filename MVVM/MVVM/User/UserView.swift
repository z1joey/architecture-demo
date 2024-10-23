import SwiftUI
import CoolDesign

struct UserView: View {
    @StateObject var viewModel: ViewModel

    @State private var login: String?
    @State private var bio: String?
    @State private var avatar: String?

    var body: some View {
        VStack {
            List {
                Section("Profile") {
                    VStack {
                        AsyncImage(url: URL(string: avatar ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        } placeholder: {
                            ZStack {
                                Text(viewModel.user)
                                    .foregroundColor(.primary)
                                    .font(.title3)
                                    .bold()
                                Circle()
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(width: 120, height: 120)
                        .padding()
                        
                        if let login {
                            Text(login).bold().font(.title)
                        }
                        
                        if let bio {
                            Text(bio).font(.body).padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }

            VStack(spacing: 10){
                CoolButton(
                    title: .constant("Try again"),
                    isLoading: $viewModel.isLoading,
                    action: viewModel.request
                )

                if let showRootView = viewModel.showRootView {
                    CoolButton(
                        title: .constant("Deeplink to root"),
                        isLoading: .constant(false),
                        action: showRootView
                    )
                }
            }
        }
        .onReceive(viewModel.$gitHubUser) {
            login = $0?.login
            bio = $0?.bio
            avatar = $0?.avatarUrl
        }
        .onAppear {
            UserEvent.screenViewed().log()
            // Wait until render/layout finished
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                viewModel.request()
            }
        }
    }
}

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
