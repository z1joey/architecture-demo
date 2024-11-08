import Combine
import Foundation

protocol SignInProvider {
    func signIn() -> AnyPublisher<GitHubUser, Error>
}

struct RealSignInProvider: SignInProvider, APICaller {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func signIn() -> AnyPublisher<GitHubUser, Error> {
        call(API.signIn)
    }
}

struct FakeSignInProvider: SignInProvider {
    func signIn() -> AnyPublisher<GitHubUser, Error> {
        Just(GitHubUser(login: "", avatarUrl: "", bio: ""))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

private extension RealSignInProvider {
    enum API: APIRequest {
        case signIn

        var path: String {
            switch self {
            case .signIn:
                return "/users/z1joey"
            }
        }

        var method: HTTP.Method {
            switch self {
            case .signIn:
                return .get
            }
        }

        var headers: [String : String]? {
            switch self {
            case .signIn:
                return nil
            }
        }
    }
}
