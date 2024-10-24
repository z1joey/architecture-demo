import SwiftUI

struct EntranceView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List {
            Section("Closure") {
                VStack {
                    TextField(
                        "Enter a GitHub user name",
                        text: $viewModel.userName
                    )
                    .textFieldStyle(.roundedBorder)
                    .textCase(.lowercase)
                    .multilineTextAlignment(.center)
                    .padding()
                    
                    Button("Continue") {
                        viewModel.showUser()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.userName.isEmpty)
                }
            }

            Section("Deeplinks") {
                ForEach(viewModel.deeplinks, id: \.url) { item in
                    Button(item.name) { viewModel.open(deeplink: item) }
                }
            }
        }
        .onAppear { EntranceEvent.screenViewed.log() }
        .navigationTitle("Navigation")
    }
}

struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView(viewModel: .init(
            deeplinks: [AnyDeeplink(url: URL(string: "demo://user/z1joey")!)])
        )
    }
}
