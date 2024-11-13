//
//  HomeView.swift
//  FactoryVIPER
//
//  Created by Joey Zhang on 2024/11/13.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var interactor: Interactor
    @State private var user: GitHubUser?

    init(interactor: Interactor = .init()) {
        self.interactor = interactor
    }

    var body: some View {
        VStack(spacing: 20) {
            if let user {
                Text("Hello, \(user.login)")
                Text(user.bio)
            } else {
                Text("Oops, something went wrong.")
            }
        }
        .onReceive(interactor.user) { user = $0 }
    }
}

#Preview {
    HomeView()
}
