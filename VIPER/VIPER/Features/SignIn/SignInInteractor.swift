import Combine
import Foundation

extension SignIn {
    class Interactor: ObservableObject {
        func signIn() -> AnyPublisher<Bool, Error> {
            Future { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    promise(.success(true))
                }
            }
            .eraseToAnyPublisher()
        }
    }
}
