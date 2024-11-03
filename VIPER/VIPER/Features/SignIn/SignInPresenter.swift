import Combine
import SwiftUI

class SignInPresenter: ObservableObject {
    private var router: SignInRouting
    private var interactor: SignInInteractorProtocol
    private var cancellables = Set<AnyCancellable>()

    @Published var path: NavigationPath

    init(router: SignInRouting,
         interactor: SignInInteractorProtocol,
         path: NavigationPath = .init()
    ) {
        self.router = router
        self.interactor = interactor
        self.path = path
    }

    func userSignedIn() {
        backToTermsTapped()
        router.showUserProfile()
    }

    func showSecondTab() {
        userSignedIn()
        router.show2ndTab()
    }

    func continueTapped() {
        path.append(SignInDestination.signIn)
    }

    func signInTapped() {
        path.append(SignInDestination.success)
    }

    func backToTermsTapped() {
        path = NavigationPath()
    }
}
