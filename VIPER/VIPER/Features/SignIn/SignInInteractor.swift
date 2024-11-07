import Combine
import Foundation

protocol SignInInteractor {
    func signIn() -> AnyPublisher<String, Error>
}

extension SignIn {
    struct Interactor: SignInInteractor {
        func signIn() -> AnyPublisher<String, Error> {
            let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
            let request = URLRequest(url: url)
            return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTP.Error.invalidResponse
                }
                guard httpResponse.statusCode == 200 else {
                    throw HTTP.Error.statusCode(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: [TodoEntity].self, decoder: JSONDecoder())
            .mapError { error -> HTTP.Error in
                if let httpError = error as? HTTP.Error {
                    return httpError
                }
                return HTTP.Error.unknown(error)
            }
            .eraseToAnyPublisher()
        }
    }
}
