import SwiftUI

extension SignIn {
    struct Routing: Equatable {
        var path: NavigationPath = .init()
    }

    enum Destination: Hashable {
        case success
    }
}
