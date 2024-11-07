import Combine
import Foundation

protocol SignInInteractorable {
    func signIn() -> AnyPublisher<Bool, Error> 
}

struct SignInInteractor: SignInInteractorable {
    func signIn() -> AnyPublisher<Bool, Error> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success(true))
            }
        }
        .eraseToAnyPublisher()
    }
}
