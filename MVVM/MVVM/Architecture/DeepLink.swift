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

protocol DeeplinkHandlerDependency {
    var deeplink: Deeplink { get }
    var coordinator: ContentView.Coordinator { get }
}

struct DeeplinkDependencyImp: DeeplinkHandlerDependency {
    var deeplink: Deeplink
    var coordinator: ContentView.Coordinator
}

struct DeeplinkHandler: Excutable {
    var dependency: DeeplinkHandlerDependency

    init(dependency: DeeplinkHandlerDependency) {
        self.dependency = dependency
    }

    func execute() {
        if case let .User(id) = Destination(deeplink: dependency.deeplink) {
            dependency.coordinator.showUser(id)
        } else {
            dependency.coordinator.showRoot()
        }
    }
}
