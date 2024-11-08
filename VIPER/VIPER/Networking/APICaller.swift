import Foundation
import Combine

protocol APICaller {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }

    func call<E: Decodable>(_ endpoint: APIRequest) -> AnyPublisher<E, Error>
}

extension APICaller {
    func call<E: Decodable>(_ endpoint: APIRequest) -> AnyPublisher<E, Error> {
        let request = endpoint.request(baseURL: baseURL)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                assert(!Thread.isMainThread)

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTP.Error.invalidResponse
                }
                guard HTTPCodes.Success.contains(httpResponse.statusCode) else {
                    throw HTTP.Error.statusCode(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: E.self, decoder: decoder)
            .mapError { error -> HTTP.Error in
                if let httpError = error as? HTTP.Error {
                    return httpError
                }
                return HTTP.Error.unknown(error)
            }
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
