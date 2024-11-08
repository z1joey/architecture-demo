import Combine
import Foundation

struct AppContext {
    let appState: AppStateSubject
    let interactors: Interactors

    private let systemEventsHandler: SystemEventsHandling

    init(appState: AppStateSubject, interactors: Interactors, systemEventsHandler: SystemEventsHandling) {
        self.appState = appState
        self.interactors = interactors
        self.systemEventsHandler = systemEventsHandler
    }
}

extension AppContext {
    struct Interactors {
        let signIn: SignInInteractor
    }
}

//MARK: Static

extension AppContext {
    static func build() -> (Self, SystemEventsHandling) {
        let appState = AppStateSubject(AppState())
        let systemEventsHandler = SystemEventsHandler(appState: appState)
        let interactors = configuredInteractors()
        let context = AppContext(
            appState: appState,
            interactors: interactors,
            systemEventsHandler: systemEventsHandler
        )

        return (context, systemEventsHandler)
    }

    static func configuredInteractors() -> Interactors {
        let signInProvider = RealSignInProvider(
            session: AppContext.configuredURLSession(),
            baseURL: "https://api.github.com"
        )
        return Interactors(
            signIn: SignIn.Interactor(provider: signInProvider)
        )
    }

    static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
}
