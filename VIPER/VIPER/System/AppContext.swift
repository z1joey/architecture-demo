import Combine
import Foundation

protocol InteractorSet {
    var signIn: SignIn.Interactor { get }
}

struct AppContext {
    let appState: AppStateSubject
    let interactors: InteractorSet

    private let systemEventsHandler: SystemEventsHandling

    init(appState: AppStateSubject, interactors: InteractorSet, systemEventsHandler: SystemEventsHandling) {
        self.appState = appState
        self.interactors = interactors
        self.systemEventsHandler = systemEventsHandler
    }
}

extension AppContext {
    class Interactors: InteractorSet {
        lazy var signIn: SignIn.Interactor = {
            let signInProvider = RealSignInProvider(
                session: configuredURLSession(),
                baseURL: Environment.apiBaseURL
            )

            return SignIn.Interactor(provider: signInProvider)
        }()
    }
}

//MARK: Static

extension AppContext {
    static func buildWithAppState(_ appState: AppStateSubject) -> (Self, SystemEventsHandling) {
        let systemEventsHandler = SystemEventsHandler(appState: appState)
        let interactors = Interactors()
        let context = AppContext(
            appState: appState,
            interactors: interactors,
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
