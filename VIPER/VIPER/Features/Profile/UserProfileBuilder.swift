import SwiftUI

class UserProfileBuilder: Buildable {
    var path: NavigationPath = .init()
    var router: UserProfileRouting?

    func withRouter(_ router: UserProfileRouting) -> Self {
        self.router = router
        return self
    }

    func build() -> some View {
        guard let router else {
            fatalError("invalid router")
        }

        let presenter = UserProfilePresenter(
            router: router,
            interactor: UserProfileInteractor(),
            path: path
        )

        return UserProfileNavigationView(presenter: presenter)
    }
}

private struct UserProfileNavigationView: View {
    @StateObject var presenter: UserProfilePresenter

    var body: some View {
        NavigationStack(path: $presenter.path) {
            UserProfileView()
                .environmentObject(presenter)
        }
    }
}

struct UserProfileNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileBuilder().build()
    }
}
