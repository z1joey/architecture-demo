import Foundation

struct HTTP {
    enum Method: String {
        case get
        case post
        case put
        case delete
        case patch
    }

    enum Error: LocalizedError {
        case unknown(Swift.Error)
        case invalidResponse
        case statusCode(Int)
        case invalidData
        case invalidURL
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let Success = 200 ..< 300
}
