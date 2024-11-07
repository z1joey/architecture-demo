import Combine
import Foundation

protocol SignInProvider {
    func signIn() -> AnyPublisher<String, Error>
}

struct SignInInteractor: SignInProvider {
    func signIn() -> AnyPublisher<String, Error> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success("user token"))
            }
        }
        .eraseToAnyPublisher()
    }
}
