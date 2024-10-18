//
//  ContentView.swift
//  MVVM
//
//  Created by Joey Zhang on 2024/10/17.
//

import SwiftUI
import DataAccess

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120, height: 120)

            Text(viewModel.viewState?.login ?? "login")
                .bold()
                .font(.title3)

            Text(viewModel.viewState?.bio ?? "bio")
                .padding()

            Button("request") {
                viewModel.fetch(user: "z1joey")
            }

            Spacer()
        }
        .padding()
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        private let userProvider: GitHubUserProviderProtocol
        @Published var viewState: ViewState?

        init(userProvider: GitHubUserProviderProtocol) {
            self.userProvider = userProvider
        }

        func fetch(user: String) {
            Task {
                let user = try await userProvider.fetch(user: user)

                await MainActor.run {
                    viewState = Presenter.format(user: user)
                }
            }
        }
    }

    class ViewState: ObservableObject {
        let login: String
        let bio: String

        init(login: String, bio: String) {
            self.login = login
            self.bio = bio
        }
    }

    struct Presenter {
        static func format(user: GitHubUser) -> ViewState {
            ViewState(login: user.login, bio: user.bio)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(userProvider: GitHubUserProvider()))
    }
}
