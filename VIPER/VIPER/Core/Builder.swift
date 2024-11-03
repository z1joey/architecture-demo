import SwiftUI

protocol Buildable: AnyObject {
    associatedtype ViewType: View
    associatedtype Routing

    var path: NavigationPath { get set }
    var router: Routing? { get set }

    func build() -> ViewType
}

extension Buildable {
    func withPath<Path: Hashable>(_ elements: [Path]) -> Self {
        self.path = .init(elements)
        return self
    }

    func withRouter(_ router: Routing) -> Self {
        self.router = router
        return self
    }
}
