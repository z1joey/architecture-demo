import Combine
import Foundation

protocol SignInInteractor {
    func signIn() -> AnyPublisher<GitHubUser, Error>
}

extension SignIn {
    struct Interactor: SignInInteractor {
        private let provider: SignInProvider

        init(provider: SignInProvider) {
            self.provider = provider
        }

        func signIn() -> AnyPublisher<GitHubUser, Error> {
            provider.signIn()
        }
    }
}
