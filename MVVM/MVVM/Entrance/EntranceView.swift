import SwiftUI

struct EntranceView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .center) {
            TextField(
                "Enter a GitHub user name",
                text: $viewModel.userName
            )
            .textFieldStyle(.roundedBorder)
            .textCase(.lowercase)
            .multilineTextAlignment(.center)
            .padding()

            Button("Proceed to continue") {
                viewModel.showUser()
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.userName.isEmpty)
        }
        .onAppear { EntranceEvent.screenViewed.log() }
    }
}

struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView(viewModel: .init())
    }
}
