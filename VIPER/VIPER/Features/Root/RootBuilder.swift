import SwiftUI

class RootBuilder: Buildable {
    func build() -> some View {
        return RootView(interactor: RootInteractor())
    }
}
