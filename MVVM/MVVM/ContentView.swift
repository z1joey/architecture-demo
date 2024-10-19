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
    @State private var viewState: ViewState?

    var body: some View {
        VStack {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120, height: 120)

            Text(viewState?.login ?? "login")
                .bold()
                .font(.title3)

            Text(viewState?.bio ?? "bio")
                .padding()

            Button("request") {
                viewModel.fetch(user: "z1joey")
            }

            Spacer()
        }
        .padding()
        .onReceive(viewModel.viewState) { self.viewState = $0 }
    }
}

// MARK: Architecuture

import Combine

extension ContentView {
    class ViewModel: ObservableObject {
        private let userProvider: GitHubUserProviderProtocol
        var viewState: PassthroughSubject<ViewState, Never> = .init()

        init(userProvider: GitHubUserProviderProtocol) {
            self.userProvider = userProvider
        }

        func fetch(user: String) {
            Task { @MainActor in
                let user = try await userProvider.fetch(user: user)
                viewState.send(Presenter.format(user: user))
            }
        }
    }
}

// MARK: The above should not be nested to avoid preview failure
struct Presenter {
    static func format(user: GitHubUser) -> ViewState {
        ViewState(login: user.login, bio: user.bio)
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

// MARK: Mock
struct StubGitHubUserProvider: GitHubUserProviderProtocol {
    func fetch(user: String) async throws -> GitHubUser {
        return .init(login: "", avatarUrl: "", bio: "")
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView(viewModel: .init(
            userProvider: StubGitHubUserProvider()
        ))
    }
}
