import Foundation

protocol Deeplink {
    var url: URL { get }
}

extension Deeplink {
    var name: String {
        url.pathComponents.last ?? url.absoluteString
    }
}

enum DeeplinkProvider: String, CaseIterable, Deeplink {
    case z1joey, iamshaunjp, OrangesChen, stephencelis, xiaoojun

    var url: URL {
        URL(string: "demo://user/\(self.rawValue)")!
    }
}

struct AnyDeeplink: Deeplink {
    var url: URL
}

protocol DeeplinkHandlerProtocol {
    func open(deeplink: Deeplink)
}

struct DeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var coordinator: Coordinator?

    func open(deeplink: Deeplink) {
        if let userId = deeplink.url.pathComponents.last {
            coordinator?.showUser(userId)
            return
        }

        coordinator?.showRoot()
    }

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}
