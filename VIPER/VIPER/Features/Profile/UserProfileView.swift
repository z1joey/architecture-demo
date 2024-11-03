import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var presenter: UserProfilePresenter

    var body: some View {
        VStack(spacing: 20) {
            Text(presenter.userName)
            Button("viper://whatever/joey") {
                UIApplication.shared.open(URL(string: "viper://whatever/joey")!)
            }

            Button("Log Out") {
                presenter.logOutTapped()
            }
        }
        .onAppear {
            presenter.getUser("hhh")
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static let interactor = UserProfileInteractor()

    static var previews: some View {
        UserProfileView()
    }
}
