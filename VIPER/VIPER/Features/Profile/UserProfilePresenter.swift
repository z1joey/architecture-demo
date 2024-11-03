import Combine
import SwiftUI

class UserProfilePresenter: ObservableObject {
    private var router: UserProfileRouting
    private var interactor: UserProfileInteractorProtocol
    private var cancellables = Set<AnyCancellable>()

    @Published var userName: String = ""
    @Published var path: NavigationPath = .init()

    init(
        router: UserProfileRouting,
        interactor: UserProfileInteractorProtocol,
        path: NavigationPath = .init()
    ) {
        self.router = router
        self.interactor = interactor
        self.path = path
    }

    func getUser(_ user: String) {
        interactor
            .getUser(user)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] userName in
                self?.userName = userName
            }
            .store(in: &cancellables)
    }

    func logOutTapped() {
        router.routeToSignIn()
    }
}
