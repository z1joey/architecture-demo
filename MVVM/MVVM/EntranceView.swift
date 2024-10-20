//
//  EntranceView.swift
//  MVVM
//
//  Created by Joey Zhang on 2024/10/20.
//

import SwiftUI

struct EntranceView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .center) {
            TextField(
                "Enter a GitHub user name and try",
                text: $viewModel.userName
            )
            .textFieldStyle(.roundedBorder)
            .textCase(.lowercase)
            .multilineTextAlignment(.center)
            .padding()

            Button("Try") {
                viewModel.showUser()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

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

struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView(viewModel: .init())
    }
}
