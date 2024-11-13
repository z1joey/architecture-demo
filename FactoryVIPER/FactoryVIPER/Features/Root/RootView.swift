import SwiftUI

struct RootView: View {
    @ObservedObject var interactor: Interactor

    init(interactor: Interactor = .init()) {
        self.interactor = interactor
    }

    var body: some View {
        VStack {
            HomeView()
        }
        .fullScreenCover(isPresented: $interactor.routing.signInSheet) {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
