import Foundation

class RootInteractor: DeepLinkDelegate {
    func open(_ url: URL) {
        print(url.absoluteString)
    }
}
