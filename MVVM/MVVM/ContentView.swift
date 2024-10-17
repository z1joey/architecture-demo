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
    @State var user: GitHubUser?

    var body: some View {
        VStack {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120, height: 120)

            Text(user?.login ?? "login")
                .bold()
                .font(.title3)

            Text(user?.bio ?? "bio")
                .padding()

            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await viewModel.fetch(user: "z1joey")
            } catch {
                print(error)
            }
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        private let userProvider: GitHubUserProviderProtocol

        init(userProvider: GitHubUserProviderProtocol) {
            self.userProvider = userProvider
        }

        func fetch(user: String) async throws -> GitHubUser {
            try await userProvider.fetch(user: user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(userProvider: GitHubUserProvider()))
    }
}
