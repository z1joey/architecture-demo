import Combine
import Foundation

protocol UserProfileInteractorProtocol {
    func getUser(_ user: String) -> AnyPublisher<String, Error>
}

struct UserProfileInteractor: UserProfileInteractorProtocol {
    func getUser(_ user: String) -> AnyPublisher<String, Error> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success("success"))
            }
        }
        .eraseToAnyPublisher()
    }
}
