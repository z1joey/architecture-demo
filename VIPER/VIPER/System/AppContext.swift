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
            session: configuredURLSession(),
            baseURL: Environment.apiBaseURL
        )
    }
}

//MARK: Static

extension AppContext {
    static func buildWithAppState(_ appState: AppStateSubject) -> (Self, SystemEventsHandling) {
        let systemEventsHandler = SystemEventsHandler(appState: appState)
        let context = AppContext(
            appState: appState,
            dataAccess: RealDataAccess(),
            systemEventsHandler: systemEventsHandler
        )

        return (context, systemEventsHandler)
    }
}

private func configuredURLSession() -> URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 60
    configuration.timeoutIntervalForResource = 120
    configuration.waitsForConnectivity = true
    configuration.httpMaximumConnectionsPerHost = 5
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    configuration.urlCache = .shared
    return URLSession(configuration: configuration)
}
