import SwiftUI

class RootBuilder {
    func build() -> some View {
        return RootView(interactor: RootInteractor())
    }
}
