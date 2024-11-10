import Combine
import Foundation

protocol APIRequest {
    var path: String { get }
    var method: HTTP.Method { get }
    var headers: [String: String]? { get }

    //func body() throws -> Data?
    func request(baseURL: String) -> URLRequest
}

extension APIRequest {
    func request(baseURL: String) -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            fatalError(HTTP.Error.invalidURL.localizedDescription)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        //request.httpBody = try body()
        return request
    }
}