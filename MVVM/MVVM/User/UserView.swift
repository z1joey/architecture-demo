import SwiftUI
import CoolDesign

struct UserView: View {
    @ObservedObject var viewModel: ViewModel

    @State private var login: String?
    @State private var bio: String?
    @State private var avatar: String?

    var body: some View {
        VStack {
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

                Text(login ?? "")
                    .bold()
                    .font(.title)
                    .padding()

                Text(bio ?? "")
                    .font(.body)
                    .padding()
            }

            VStack {
                CoolButton(
                    title: .constant("Fetch profile"),
                    isLoading: $viewModel.isLoading,
                    action: viewModel.request
                )
                .padding()

                CoolButton(
                    title: .constant("Back to root"),
                    isLoading: .constant(false),
                    action: viewModel.showRootView!
                )
                .padding()
            }

            Spacer()
        }
        .onReceive(viewModel.$gitHubUser) {
            login = $0?.login
            bio = $0?.bio
            avatar = $0?.avatarUrl
        }
        .onAppear { UserEvent.screenViewed().log() }
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
