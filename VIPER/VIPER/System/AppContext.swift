import Combine
import Foundation

protocol DataAccess {
    var signInProvider: SignInProvider { get }
}

struct AppContext {
    let appState: AppStateSubject
    let dataAccess: DataAccess

    private let systemEventsHandler: SystemEventsHandling

    init(appState: AppStateSubject, dataAccess: DataAccess, systemEventsHandler: SystemEventsHandling) {
        self.appState = appState
        self.dataAccess = dataAccess
        self.systemEventsHandler = systemEventsHandler
    }
}

extension AppContext {
    class RealDataAccess: DataAccess {
        lazy var signInProvider: SignInProvider = RealSignInProvider(
            session: URLSession.configured,
            baseURL: Environment.apiBaseURL
        )
    }
}

//MARK: Static

extension AppContext {
    static func build(withAppState appState: AppStateSubject) -> (Self, SystemEventsHandling) {
        let systemEventsHandler = SystemEventsHandler(appState: appState)
        let context = AppContext(
            appState: appState,
            dataAccess: RealDataAccess(),
            systemEventsHandler: systemEventsHandler
        )

        return (context, systemEventsHandler)
    }
}

private extension URLSession {
    static var configured: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
}
